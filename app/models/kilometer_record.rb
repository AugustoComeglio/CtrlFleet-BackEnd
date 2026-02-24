# frozen_string_literal: true

class KilometerRecord < ApplicationRecord
  acts_as_paranoid

  include KilometerRecord::Reportable

  after_create :send_notification

  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :unit, class_name: 'Unit'

  delegate :name, to: :unit, prefix: true
  delegate :license_plate, to: :vehicle, prefix: true

  validates :registered_at, :kms_traveled, presence: { message: I18n.t(:field_is_required) }

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
                            "Se han cargado kilometros en tu vehiculo",
                            "Tu vehiculo #{vehicle.brand_name} #{vehicle.model_name} (patente #{vehicle.license_plate.upcase}) tiene un nuevo registro de kilometros",
                            vehicle_id, vehicle.class.to_s).exec
  end
end
