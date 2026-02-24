# frozen_string_literal: true

class Vehicle < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :fecha_de_creacion, :created_at
      alias_attribute :patente, :license_plate
      alias_attribute :fabricado, :production_year
      alias_attribute :kilometros_iniciales, :initial_kms
      alias_attribute :capacidad_de_combustible, :tank_capacity
    end

    module InstanceMethods
      def tipo_de_vehiculo
        vehicle_type.try(:name)
      end

      def tipo_de_combustible
        fuel_type.try(:name)
      end

      def conductor
        "#{driver.try(:first_name)} #{driver.try(:last_name)}"
      end

      def pertenece_a_flota
        fleet.try(:name)
      end

      def deposito
        warehouse_name
      end

      def creado_por
        manager_email
      end

      def marca
        brand_name
      end

      def modelo
        model_name
      end
    end
  end
end
