# frozen_string_literal: true

class Vehicle < ApplicationRecord
  acts_as_paranoid

  include Vehicle::Reportable

  after_create :add_initial_state
  after_save :send_notification

  belongs_to :vehicle_type, class_name: 'VehicleType', optional: true
  belongs_to :fuel_type, class_name: 'FuelType'
  belongs_to :warehouse, class_name: 'Warehouse'
  belongs_to :manager, class_name: 'User'
  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :brand, class_name: 'Brand'
  belongs_to :model, class_name: 'Model'
  belongs_to :fleet, class_name: 'Fleet', optional: true

  alias type vehicle_type

  delegate :email, to: :manager, prefix: true, allow_nil: true
  delegate :email, to: :driver, prefix: true, allow_nil: true
  delegate :name, to: :brand, prefix: true, allow_nil: true
  delegate :name, to: :model, prefix: true, allow_nil: true
  delegate :name, to: :warehouse, prefix: true, allow_nil: true
  delegate :name, to: :type, prefix: true, allow_nil: true
  delegate :name, to: :fleet, prefix: true, allow_nil: true

  has_many :documents, class_name: 'Document', dependent: :destroy
  has_many :images, class_name: 'Image', dependent: :destroy
  has_many :maintenances, class_name: 'Maintenance', dependent: :destroy
  has_many :fuel_records, class_name: 'FuelRecord', dependent: :destroy
  has_many :kilometer_records, class_name: 'KilometerRecord', dependent: :destroy
  has_many :failures, class_name: 'Failure', dependent: :destroy

  has_many :vehicle_states, class_name: 'VehicleState', dependent: :destroy
  has_many :state_vehicles, through: :vehicle_states, class_name: 'StateVehicle', source: :state_vehicle

  validates :color,
            format: { with: /\A[\p{L}\p{M}]{2,20}[" ]?[\p{L}\p{M}]?{2,20}[" ]?[\p{L}\p{M}]?{2,20}\z/,
                      message: I18n.t(:should_be_only_letter) }
  validates :initial_kms, numericality: { only_integer: true, message: I18n.t(:should_be_only_integer) }
  validates :license_plate, presence: { message: I18n.t(:license_plate_field_is_required) },
                            uniqueness: { message: I18n.t(:already_exists_vehicle_with_license_plate) },
                            length: { maximum: 8, message: I18n.t(:license_plate_too_many_long) }

  def images_json
    images.map do |img|
      {
        id: img.try(:id),
        url: img.url
      }
    end
  end

  def state
    state_vehicles.joins(:vehicle_states).order('vehicle_states.created_at').last&.name
  end

  def change_state!(new_state)
    return true if new_state == state

    VehicleState.create(vehicle_id: self.id, state_vehicle_id: StateVehicle.find_by(name: new_state).try(:id))
  end

  def current_kms
    initial_kms.to_f + kilometer_records.sum(:kms_traveled)
  end

  private

  def add_initial_state
    VehicleState.create(vehicle_id: self.id, state_vehicle_id: StateVehicle.find_by(name: 'activo').id)
  end

  def send_notification
    if driver_id_changed?
      NotificationService.new(driver, 'Fuiste asignado a un Vehiculo', "Hola #{user.email} eres el nuevo conductor de #{brand_name} #{model_name} (patente #{license_plate.upcase}).").exec
    elsif vehicle_type_id.nil? && !vehicle_type_id_was.nil?
      NotificationService.new(manager, 'Debes actualizar tu vehiculo', "El tipo de vehiculo asociado a tu vehiculo #{brand_name} #{model_name} (patente #{license_plate.upcase}) ha sido eliminado.").exec
    end
  end
end
