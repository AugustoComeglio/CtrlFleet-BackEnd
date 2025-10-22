# frozen_string_literal: true

class FuelRecord < ApplicationRecord
  acts_as_paranoid

  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :unit, class_name: 'Unit'
  belongs_to :gas_station, class_name: 'GasStation'
  belongs_to :fuel_type, class_name: 'FuelType'

  delegate :name, to: :gas_station, prefix: true
  delegate :name, to: :unit, prefix: true
  delegate :license_plate, to: :vehicle, prefix: true

  validates :registered_at, :quantity, :unit_price, presence: true

  def vehicle_hash
    {
      license_plate: vehicle.license_plate,
      vehicle_type: vehicle.vehicle_type.name,
      brand: vehicle.brand_name,
      model: vehicle.model_name,
      production_year: vehicle.production_year
    }
  end
end
