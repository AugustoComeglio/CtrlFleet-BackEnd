# frozen_string_literal: true

class StateMaintenance < ApplicationRecord
  acts_as_paranoid

  has_many :maintenance_states, class_name: 'MaintenanceState', dependent: :destroy
  has_many :maintenances, through: :maintenance_states, class_name: 'Maintenance', source: :state_maintenance

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Estado de Mantenimiento') }
end
