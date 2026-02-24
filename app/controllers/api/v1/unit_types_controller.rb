# frozen_string_literal: true

module Api
  module V1
    class UnitTypesController < Api::BaseController
      before_action :find_unit_type, only: %i[show update destroy units]

      def index
        @unit_types = UnitType.all.order(:name)

        render json: { data: @unit_types.as_json(only: %i[id name]) }, status: :ok
      end

      def show
        if @unit_type
          render json: { data: @unit_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Tipo de Unidad #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @unit_type = UnitType.new unit_type_params

        if @unit_type.save
          render json: { data: @unit_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @unit_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @unit_type.update unit_type_params
          render json: { data: @unit_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @unit_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @unit_type.destroy
          render json: { message: 'Tipo de Unidad eliminado con exito' }, status: :ok
        else
          render json: { message: @unit_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def units
        render json: { data: @unit_type.units.order(:name).as_json(only: %i[id name]) }, status: :ok
      end

      private

      def find_unit_type
        @unit_type = UnitType.find_by id: params[:id]
      end

      def unit_type_params
        params.require(:unit_type).permit :name
      end
    end
  end
end
