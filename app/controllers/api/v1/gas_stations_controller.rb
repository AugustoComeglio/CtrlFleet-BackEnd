# frozen_string_literal: true

module Api
  module V1
    class GasStationsController < Api::BaseController
      before_action :find_gas_station, only: %i[show update destroy]

      def index
        @gas_stations = GasStation.all.order(:name)

        render json: { data: @gas_stations.as_json(only: %i[id name]) }, status: :ok
      end

      def show
        if @gas_station
          render json: { data: @gas_station.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Estacion de Servicio #{params[:id]} no encontrada" }, status: :not_found
        end
      end

      def create
        @gas_station = GasStation.new gas_station_params

        if @gas_station.save
          render json: { data: @gas_station.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @gas_station.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @gas_station.update gas_station_params
          render json: { data: @gas_station.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @gas_station.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @gas_station.destroy
          render json: { message: 'Estacion de Servicio eliminado con exito' }, status: :ok
        else
          render json: { message: @gas_station.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_gas_station
        @gas_station = GasStation.find_by id: params[:id]
      end

      def gas_station_params
        params.require(:gas_station).permit :name
      end
    end
  end
end
