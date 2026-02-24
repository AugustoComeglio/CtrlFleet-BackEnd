# frozen_string_literal: true

class Maintenance < ApplicationRecord
  acts_as_paranoid

  include MaintenancePlan::Reportable

  after_create :add_initial_state
  after_save :send_notification

  belongs_to :maintenance_plan, class_name: 'MaintenancePlan', optional: true
  belongs_to :maintenance_type, class_name: 'MaintenanceType'
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle, class_name: 'Vehicle'
  # belongs_to :failure, class_name: 'Failure'

  alias type maintenance_type
  alias plan maintenance_plan

  delegate :license_plate, to: :vehicle, prefix: true
  delegate :email, to: :user, prefix: true
  delegate :name, to: :maintenance_plan, prefix: true, allow_nil: true
  delegate :name, to: :maintenance_type, prefix: true

  has_many :maintenance_states, class_name: 'MaintenanceState', dependent: :destroy
  has_many :state_maintenances, through: :maintenance_states, class_name: 'StateMaintenance', source: :state_maintenance

  has_many :maintenance_spares, class_name: 'MaintenanceSpare', dependent: :destroy
  has_many :spares, through: :maintenance_spares, class_name: 'Spare', source: :spare

  scope :pending, -> { where name: 'pendiente' }
  scope :in_progress, -> { where name: 'en progreso' }
  scope :success, -> { where name: 'realizado' }

  before_validation :check_dates

  def added_spares
    spares.map do |spare|
      {
        id: spare.id,
        name: spare.name,
        brand_name: spare.brand_name,
        images_json: spare.images_json,
        quantity: spare.maintenance_spares.where(maintenance_id: id).order('created_at').last.quantity,
        maintenance_spare_id: spare.maintenance_spares.where(maintenance_id: id).order('created_at').last.id
      }
    end
  end

  def state
    state_maintenances.joins(:maintenance_states).order('maintenance_states.created_at').last.name
  end

  def change_state!(new_state)
    return true if new_state == state

    if new_state == 'realizado' && begin_at.blank?
      errors.add(:base, 'No puede finalizar un mantenimiento que no inicio')
    else
      MaintenanceState.create(maintenance_id: self.id, state_maintenance_id: StateMaintenance.find_by(name: new_state).try(:id))
    end
  end

  private

  def add_initial_state
    MaintenanceState.create(maintenance_id: self.id, state_maintenance_id: StateMaintenance.find_by(name: 'pendiente').id)
  end

  def check_dates
    if begin_at_changed? && begin_at && begin_at < Time.zone.now.beginning_of_day
      errors.add(:begin_at, message: 'No se puede ingresar una fecha menor al dia de hoy')
    elsif end_at_changed? && end_at && end_at < Time.zone.now.beginning_of_day
      errors.add(:end_at, message: 'No se puede ingresar una fecha menor al dia de hoy')
    elsif end_at_changed? && end_at && end_at < begin_at
      errors.add(:end_at, message: 'Fecha de finalizacion no puede ser menor a Fecha de inicio')
    end
  end

  def send_notification
    title = "Tu vehiculo #{state == 'en progreso' ? '' : 'NO'} se encuentra en mantenimiento"
    msg = "A tu vehiculo #{vehicle.brand_name} #{vehicle.model_name} (patente #{vehicle.license_plate.upcase}) le fue #{state == 'en progreso' ? 'iniciado' : 'finalizado'} un mantenimiento, por lo que no su estado actual es #{state}"

    if state == 'en progreso'
      NotificationService.new(vehicle.manager, title, msg, vehicle_id, vehicle.class.to_s).exec
      NotificationService.new(vehicle.driver, title, msg, vehicle_id, vehicle.class.to_s).exec
    end
  end
end
