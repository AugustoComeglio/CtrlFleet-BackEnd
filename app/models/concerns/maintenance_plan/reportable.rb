# frozen_string_literal: true

class MaintenancePlan < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :nombre, :name
    end

    module InstanceMethods
      def cantidad_de_mantenimientos
        maintenances.try(:count)
      end

      def cantidad_de_daños
        failures.try(:count)
      end

      def responsable
        user.try(:full_name)
      end

      def fecha_inicio
        maintenances.pluck(:begin_at).reject(&:nil?).min
      end

      def fecha_fin
        maintenances.pluck(:end_at).reject(&:nil?).max
      end
    end
  end
end
