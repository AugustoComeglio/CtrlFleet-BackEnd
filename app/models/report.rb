# frozen_string_literal: true

class Report < ApplicationRecord
  TYPES = %w[vehicles users fleets_per_warehouse spares maintenance_plans debates failures fuel_types].freeze
end
