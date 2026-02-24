# frozen_string_literal: true

class FuelRecord < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :precio_unitario, :unit_price
      alias_attribute :observacion, :observation
      alias_attribute :fecha_registro, :registered_at
    end

    module InstanceMethods
      def vehiculo
        vehicle.try(:license_plate)
      end

      def flota_del_vehiculo
        vehicle.try(:fleet).try(:name)
      end

      def tipo_de_combustible
        fuel_type.try(:name)
      end

      def cantidad
        "#{quantity} #{unit_name}"
      end

      def total
        quantity * unit_price
      end

      def estacion
        gas_station_name
      end
    end
  end
end
