# frozen_string_literal: true

class KilometerRecord < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

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

      def kilometros_recorridos
        "#{kms_traveled} #{unit_name}"
      end
    end
  end
end
