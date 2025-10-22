# frozen_string_literal: true

class Vehicle < ApplicationRecord
  acts_as_paranoid

  belongs_to :vehicle_type, class_name: 'VehicleType'
  belongs_to :fuel_type, class_name: 'FuelType'
  belongs_to :warehouse, class_name: 'Warehouse'
  belongs_to :manager, class_name: 'User'
  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :brand, class_name: 'Brand'
  belongs_to :model, class_name: 'Model'
  belongs_to :fleet, class_name: 'Fleet'

  alias type vehicle_type

  has_many :maintenances, class_name: 'Maintenance', dependent: :destroy
  has_many :fuel_records, class_name: 'FuelRecord', dependent: :destroy
  has_many :kilometer_records, class_name: 'KilometerRecord', dependent: :destroy

  has_many :vehicle_states, class_name: 'VehicleState', dependent: :destroy
  has_many :state_vehicles, through: :vehicle_states, class_name: 'StateVehicle', source: :state_vehicle

  validates :color,
            format: { with: /\A[\p{L}\p{M}]{2,20}[" ]?[\p{L}\p{M}]?{2,20}[" ]?[\p{L}\p{M}]?{2,20}\z/,
                      message: 'Solo se permiten letras' }
  validates :initial_kms, numericality: { only_integer: true, message: 'Solo se permiten numeros' }
  validates :license_plate, length: { maximum: 8, message: 'El maximo de caracteres permitidos es 8' }

  delegate :email, to: :manager, prefix: true, allow_nil: true
  delegate :email, to: :driver, prefix: true, allow_nil: true
  delegate :name, to: :brand, prefix: true, allow_nil: true
  delegate :name, to: :model, prefix: true, allow_nil: true
end
