# frozen_string_literal: true

module Api
  module V1
    class VehiclesController < Api::BaseController
      before_action :find_vehicle, only: %i[show update destroy fuel_records kilometer_records]
      # Endpoint para US de "Visualizar Vehiculos"
      def index
        @vehicles = if params[:fleet_id]
                      Vehicle.where fleet_id: params[:fleet_id]
                    else
                      Vehicle.all
                    end

        render json: { data: index_json }, status: :ok
      end

      # Endpoint para US de "Ver un Vehiculo"
      def show
        if @vehicle
          render json: { data: show_json }, status: :ok
        else
          render json: { message: "No se encontro Vehiculo con ID #{params[:id]}" }, status: :not_found
        end
      end

      # Endpoint para US de "Crear Vehiculo"
      def create
        @vehicle = Vehicle.new vehicle_params
        @vehicle.manager_id = current_user_id

        if @vehicle.save
          render json: { data: show_json }, status: :ok
        else
          render json: { message: @vehicle.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      # Endpoint para US de "Modificar o Actualizar Vehiculo"
      def update
        if @vehicle.update vehicle_params
          render json: { data: show_json }, status: :ok
        else
          render json: { message: @vehicle.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      # Endpoint para US de "Eliminar Vehiculo"
      def destroy
        if @vehicle.destroy
          render json: { message: 'Vehiculo elminado con exito' }, status: :ok
        else
          render json: { message: @vehicle.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      # Endpoint para consultar registros de combustibles de un vehiculo
      def fuel_records
        render json: { data: @vehicle&.fuel_records.as_json(except: %i[created_at updated_at deleted_at
                                                                       unit_id gas_station_id],
                                                            methods: %i[gas_station_name unit_name]) }
      end

      # Endpoint para consultar registros de kilometros de un vehiculo
      def kilometer_records
        render json: { data: @vehicle&.kilometer_records&.as_json(except: %i[created_at updated_at deleted_at],
                                                                  methods: %i[unit_name]) }
      end

      # Endpoint para monitoreo de combustible
      def fuel_records_monitoring
        resp_json = { count_quantity_per_month: {}, amount_per_month: {}, amount_per_gas_station: {} }

        # Cantidad mensual de litros de registros de combustibles por unidad
        resp_json[:count_quantity_per_month] = @vehicle.fuel_records
                             .group_by { |record| record.registered_at.beginning_of_month.strftime('%B').downcase }
                             .map do |month, records|
          [
            month,
            records.group_by { |r| r.unit.name }
                   .map { |unit, rr| [unit, rr.sum(&:quantity)] }.to_h
          ]
        end.to_h

        # Cantidad mensual de plata de registros de combustibles por unidad
        resp_json[:amount_per_month] = @vehicle.fuel_records.group_by { |record| record.registered_at.beginning_of_month.strftime('%B').downcase }
                             .map do |month, records|
          [
            month,
            records.group_by { |r| r.unit.name }
                   .map { |unit, rr| [unit, rr.sum { |rrr| rrr.quantity * rrr.unit_price }] }.to_h
          ]
        end.to_h

        # Cantidad mensual de plata de registros de combustibles por unidad
        resp_json[:amount_per_gas_station] = @vehicle.fuel_records.group_by { |record| record.gas_station.name }
                             .map do |gas_station, records|
          [
            gas_station,
            records.group_by { |r| r.unit.name }
                   .map { |unit, rr| [unit, rr.sum(&:quantity)] }.to_h
          ]
        end.to_h

        render json: { data: resp_json }
      end

      private

      # Buscar vehiculo y guardarlo global para todo el controlador
      def find_vehicle
        @vehicle = Vehicle.find_by id: params[:id]
      end

      # Parametros permitidos para crear un vehiculo
      def vehicle_params
        params.require(:vehicle).permit :license_plate, :initial_kms, :production_year, :color, :vehicle_type_id,
                                        :fuel_type_id, :warehouse_id, :brand_id, :model_id, :tank_capacity,
                                        :driver_id, :fleet_id
      end

      # Generacion del JSON de salida para un conjuntos de vehiculos
      def index_json
        @vehicles.as_json(only: %i[id license_plate], methods: %i[brand_name model_name])
      end

      # Generacion del JSON de salida para un vehiculo
      def show_json
        @vehicle.as_json(except: %i[manager_id created_at updated_at deleted_at])
      end
    end
  end
end
