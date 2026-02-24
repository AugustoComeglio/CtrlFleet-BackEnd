# frozen_string_literal: true

class User < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :telefono, :phone
    end

    module InstanceMethods
      def nombre_y_apellido
        "#{first_name} #{last_name}"
      end

      def tipo_de_usuario
        type_name
      end

      def cantidad_de_debates
        debates.count
      end

      def cantidad_de_respuestas_a_debates
        responses.count
      end

      def conduce
        Vehicle.find_by(driver_id: id).try(:license_plate)
      end
    end
  end
end
