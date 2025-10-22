# frozen_string_literal: true

class MaintenanceState < ApplicationRecord
  belongs_to :maintenance, class_name: 'Maintenance'
  belongs_to :state_maintenance, class_name: 'StateMaintenance'
end
