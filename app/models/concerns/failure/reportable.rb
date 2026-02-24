# frozen_string_literal: true

class Failure < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :nombre, :name
      alias_attribute :detalle, :description
      alias_attribute :fecha_de_creacion, :created_at
      alias_attribute :prioridad, :priority
    end

    module InstanceMethods
      def vehiculo
        vehicle.try(:license_plate)
      end

      def usuario
        user.try(:full_name)
      end

      def incluido_en_plan
        maintenance_plan.try(:name)
      end
    end
  end
end
