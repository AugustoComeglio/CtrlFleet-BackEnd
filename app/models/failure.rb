# frozen_string_literal: true

class Failure < ApplicationRecord
  acts_as_paranoid

  belongs_to :maintenance_plan, class_name: 'MaintenancePlan'
end
