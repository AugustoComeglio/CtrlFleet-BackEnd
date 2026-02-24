# frozen_string_literal: true

module Api
  module V1
    class UnitsController < Api::BaseController
      before_action :find_unit, only: %i[show update destroy]

      def index
        @units = Unit.all.order(:name)

        render json: { data: @units.as_json(only: %i[id name], methods: %i[type_name]) }, status: :ok
      end

      def show
        if @unit
          render json: { data: @unit.as_json(only: %i[id name], methods: %i[type_name]) }, status: :ok
        else
          render json: { message: "Tipo de Unidad #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @unit = Unit.new unit_params

        if @unit.save
          render json: { data: @unit.as_json(only: %i[id name], methods: %i[type_name]) }, status: :ok
        else
          render json: { message: @unit.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @unit.update unit_params
          render json: { data: @unit.as_json(only: %i[id name], methods: %i[type_name]) }, status: :ok
        else
          render json: { message: @unit.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @unit.destroy
          render json: { message: 'Tipo de Unidad eliminado con exito' }, status: :ok
        else
          render json: { message: @unit.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_unit
        @unit = Unit.find_by id: params[:id]
      end

      def unit_params
        params.require(:unit).permit :name, :unit_type_id
      end
    end
  end
end
