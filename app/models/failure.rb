# frozen_string_literal: true

class Failure < ApplicationRecord
  acts_as_paranoid

  include Failure::Reportable

  after_create :send_notification

  belongs_to :maintenance_plan, class_name: 'MaintenancePlan'
  belongs_to :vehicle, class_name: 'Vehicle'
  belongs_to :user, class_name: 'User'

  has_many :images, class_name: 'Image', dependent: :destroy
  has_many :documents, class_name: 'Document', dependent: :destroy
  # has_many :maintenances, class_name: 'Maintenance'

  delegate :license_plate, to: :vehicle, prefix: true, allow_nil: true
  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :maintenance_plan, prefix: true, allow_nil: true

  def images_json
    images.map do |img|
      {
        id: img.try(:id),
        url: img.url
      }
    end
  end

  private

  def send_notification
    title = "Tu vehiculo esta dañado"
    msg = "A tu vehiculo #{vehicle.brand_name} #{vehicle.model_name} (patente #{vehicle.license_plate.upcase}) se le cargo un daño. El daño se regitro el dia #{created_at.strftime('%d/%m/%Y')}, por #{user.first_name} #{user.last_name}"
    NotificationService.new(vehicle.manager, title, msg, vehicle_id, vehicle.class.to_s).exec
    NotificationService.new(vehicle.driver, title, msg, vehicle_id, vehicle.class.to_s).exec
  end
end
