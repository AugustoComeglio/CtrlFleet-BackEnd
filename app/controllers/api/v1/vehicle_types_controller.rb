# frozen_string_literal: true

module Api
  module V1
    class VehicleTypesController < Api::BaseController
      before_action :find_vehicle_type, only: %i[show update destroy]

      def index
        @vehicle_types = VehicleType.all.order(:name)

        render json: { data: @vehicle_types.as_json(only: %i[id name]) }, status: :ok
      end

      def show
        if @vehicle_type
          render json: { data: @vehicle_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "No se encontro Tipo de Vehiculo con identificar #{params[:id]}" }, status: :not_found
        end
      end

      def create
        @vehicle_type = VehicleType.new vehicle_type_params

        if @vehicle_type.save
          render json: { data: @vehicle_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @vehicle_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @vehicle_type.update vehicle_type_params
          render json: { data: @vehicle_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @vehicle_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @vehicle_type.destroy
          render json: { message: 'Tipo de Vehiculo eliminado con exito' }, status: :ok
        else
          render json: { message: @vehicle_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def vehicle_type_params
        params.require(:vehicle_type).permit :name
      end

      def find_vehicle_type
        @vehicle_type = VehicleType.find_by id: params[:id]
      end
    end
  end
end
