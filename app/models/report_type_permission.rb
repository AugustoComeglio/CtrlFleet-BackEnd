# frozen_string_literal: true

class ReportTypePermission < ApplicationRecord
  TYPES = %w[vehicles users fleets_per_warehouse spares maintenance_plans debates failures fuel_types].freeze

  belongs_to :permission, class_name: 'Permission'

  self.table_name = 'report_types_permissions'
end
