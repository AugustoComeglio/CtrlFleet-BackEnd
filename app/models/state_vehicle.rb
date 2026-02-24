# frozen_string_literal: true

class StateVehicle < ApplicationRecord
  acts_as_paranoid

  has_many :vehicle_states, class_name: 'VehicleState', dependent: :destroy
  has_many :vehicles, through: :vehicle_states, class_name: 'Vehicle', source: :state_vehicle

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Estado de Vehiculo') }
end
