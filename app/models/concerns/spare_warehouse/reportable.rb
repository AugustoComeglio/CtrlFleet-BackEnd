# frozen_string_literal: true

class SpareWarehouse < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :stock, :quantity
    end

    module InstanceMethods
      def repuesto
        spare.try(:name)
      end

      def marca
        spare.try(:brand_name)
      end

      def deposito
        warehouse.try(:name)
      end
    end
  end
end
