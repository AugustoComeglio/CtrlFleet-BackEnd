# frozen_string_literal: true

module Api
  module V1
    class FuelTypesController < Api::BaseController
      before_action :find_fuel_type, only: %i[show update destroy]

      def index
        @fuel_types = FuelType.all.order(:name)

        render json: { data: @fuel_types.as_json(only: %i[id name]) }, status: :ok
      end

      def show
        if @fuel_type
          render json: { data: @fuel_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Tipo de Combustible #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @fuel_type = FuelType.new fuel_type_params

        if @fuel_type.save
          render json: { data: @fuel_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @fuel_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @fuel_type.update fuel_type_params
          render json: { data: @fuel_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @fuel_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @fuel_type.destroy
          render json: { message: 'Tipo de Combustible eliminado con exito' }, status: :ok
        else
          render json: { message: @fuel_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_fuel_type
        @fuel_type = FuelType.find_by id: params[:id]
      end

      def fuel_type_params
        params.require(:fuel_type).permit :name
      end
    end
  end
end
