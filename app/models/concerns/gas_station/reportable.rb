# frozen_string_literal: true

class GasStation < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :nombre, :name
    end

    module InstanceMethods
      def cantidad_de_registros_de_combustibles
        fuel_records_count
      end

      def fecha_ultimo_registro
        last_fuel_record_at
      end
    end
  end
end
