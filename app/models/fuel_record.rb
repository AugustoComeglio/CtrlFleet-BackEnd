# frozen_string_literal: true

class FuelRecord < ApplicationRecord
  acts_as_paranoid

  include FuelRecord::Reportable

  after_create :send_notification

  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :unit, class_name: 'Unit'
  belongs_to :gas_station, class_name: 'GasStation'
  belongs_to :fuel_type, class_name: 'FuelType', optional: true

  delegate :name, to: :gas_station, prefix: true
  delegate :name, to: :unit, prefix: true
  delegate :name, to: :fuel_type, prefix: true
  delegate :license_plate, to: :vehicle, prefix: true

  validates :registered_at, :quantity, :unit_price, presence: { message: I18n.t(:field_is_required) }

  def vehicle_hash
    {
      license_plate: vehicle.license_plate,
      brand: vehicle.brand_name,
      model: vehicle.model_name
    }
  end

  private

  def send_notification
    NotificationService.new(vehicle.manager,
                            'Se han cargado combustible en tu vehiculo',
                            "Tu vehiculo #{vehicle.brand_name} #{vehicle.model_name} (patente #{vehicle.license_plate.upcase}) tiene un nuevo registro de combustible",
                            vehicle_id, vehicle.class.to_s).exec
  end
end
