# frozen_string_literal: true

class Debate < ApplicationRecord
  module Reportable
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
      acts_as_xlsx

      alias_attribute :titulo, :subject
      alias_attribute :fecha_inicio, :begin_at
      alias_attribute :fecha_fin, :end_at
    end

    module InstanceMethods
      def cuerpo
        description.html_safe
      end

      def autor
        user.try(:full_name)
      end

      def cantidad_de_respuestas
        responses.try(:count)
      end
    end
  end
end
