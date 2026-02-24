# frozen_string_literal: true

module Api
  module V1
    class StateVehiclesController < Api::BaseController
      before_action :find_state_vehicle, only: %i[show update destroy]

      def index
        @state_vehicle = StateVehicle.all

        render json: { data: @state_vehicles.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @state_vehicle = StateVehicle.new state_vehicle_params

        if @state_vehicle.save
          render json: { data: @state_vehicle.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        if @state_vehicle
          render json: { data: @state_vehicle.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Estado de Vehiculo #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @state_vehicle.update(state_vehicle_params)
          render json: { data: @state_vehicle.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @state_vehicle.destroy
          render json: { message: 'Estado de Vehiculo eliminado con exito' }, status: :ok
        else
          render json: { message: @state_vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_state_vehicle
        @state_vehicle = StateVehicle.find_by id: params[:id]
      end

      def state_vehicle_params
        params.require(:state_vehicle).permit :name
      end
    end
  end
end
