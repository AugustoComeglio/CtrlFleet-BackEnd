# frozen_string_literal: true

class RecordsMonitoringService
  def initialize(vehicle)
    @vehicle = vehicle
  end
  
  def exec
    {
      vehicle_hash: {
        license_plate: @vehicle.license_plate,
        brand: @vehicle.brand_name,
        model: @vehicle.model_name
      },
      fuel_records_per_month: fuel_records_monitoring,
      kms_records_per_month: kms_records_monitoring,
      amount_per_month: amount_per_month,
      amount_per_gas_station: amount_per_gas_station
    }
  end

  def fuel_records_monitoring
    @vehicle.fuel_records.order(:registered_at)
            .group_by { |record| record.registered_at.beginning_of_month.strftime('%B') }
            .map.to_h do |month, records|
              [
                month_to_api[month.to_sym],
                records.group_by { |r| r.unit.name }.map.to_h { |unit, rr| [unit, rr.sum(&:quantity)] }
              ]
            end
  end

  def kms_records_monitoring
    @vehicle.kilometer_records.order(:registered_at)
            .group_by { |record| record.registered_at.beginning_of_month.strftime('%B') }
            .map.to_h do |month, records|
              [
                month_to_api[month.to_sym],
                records.group_by { |r| r.unit.name }.map.to_h { |unit, rr| [unit, rr.sum(&:kms_traveled)] }
              ]
            end
  end

  def amount_per_month
    @vehicle.fuel_records.order(:registered_at)
            .group_by { |record| record.registered_at.beginning_of_month.strftime('%B') }
            .map.to_h do |month, records|
              [
                month_to_api[month.to_sym],
                records.group_by { |r| r.unit.name }.map.to_h do |unit, rr|
                  [unit, rr.sum { |rrr| rrr.quantity * rrr.unit_price }]
                end
              ]
            end
  end

  def amount_per_gas_station
    @vehicle.fuel_records.order(:registered_at)
            .group_by { |record| record.gas_station.name }
            .map.to_h do |gas_station, records|
              [
                gas_station,
                records.group_by { |r| r.unit.name }.map.to_h { |unit, rr| [unit, rr.sum(&:quantity)] }
              ]
            end
  end

  private

  def month_to_api
    {
      'January': 'Enero',
      'February': 'Febrero',
      'March': 'Marzo',
      'April': 'Abril',
      'May': 'Mayo',
      'June': 'Junio',
      'July': 'Julio',
      'August': 'Agosto',
      'September': 'Septiembre',
      'October': 'Octubre',
      'November': 'Noviembre',
      'December': 'Diciembre'
    }
  end
end
