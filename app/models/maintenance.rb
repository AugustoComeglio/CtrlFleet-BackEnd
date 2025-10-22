# frozen_string_literal: true

class Maintenance < ApplicationRecord
  acts_as_paranoid

  belongs_to :maintenance_plan, class_name: 'MaintenancePlan'
  belongs_to :maintenance_type, class_name: 'MaintenanceType'
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle, class_name: 'Vehicle'

  validates :name, presence: true, uniqueness: { scope: :vehicle }
end
