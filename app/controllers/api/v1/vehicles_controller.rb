# frozen_string_literal: true

module Api
  module V1
    class VehiclesController < Api::BaseController
      before_action :find_vehicle, only: %i[show update destroy fuel_records kilometer_records maintenances images documents]

      # Endpoint para US de "Visualizar Vehiculos"
      def index
        @vehicles = Vehicle.all

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
          render json: { message: @vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      # Endpoint para US de "Modificar o Actualizar Vehiculo"
      def update
        if @vehicle.update vehicle_params
          @vehicle.change_state!(params[:state]) if params[:state]

          render json: { data: show_json }, status: :ok
        else
          render json: { message: @vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      # Endpoint para US de "Eliminar Vehiculo"
      def destroy
        if @vehicle.destroy
          render json: { message: 'Vehiculo elminado con exito' }, status: :ok
        else
          render json: { message: @vehicle.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      # Endpoint para consultar registros de combustibles de un vehiculo
      def fuel_records
        render json: { data: @vehicle.fuel_records.order(:registered_at)
                                     .as_json(except: %i[vehicle_id unit_id gas_station_id created_at updated_at deleted_at],
                                              methods: %i[vehicle_hash gas_station_name unit_name]) },
               status: :ok
      end

      # Endpoint para consultar registros de kilometros de un vehiculo
      def kilometer_records
        render json: { data: @vehicle.kilometer_records.order(:created_at)
                                     .as_json(except: %i[unit_id created_at updated_at deleted_at],
                                              methods: %i[vehicle_hash unit_name]) },
               status: :ok
      end

      # Endpoint para obtener los mantenimientos asociados a un vehiculo en particular
      def maintenances
        render json: { data: @vehicle.maintenances.order(:priority).as_json(except: %i[user_id created_at updated_at deleted_at], methods: %i[state maintenance_plan_name]) },
               status: :ok
      end

      # Endpoint para obtener los daños asociados a un vehiculo en particular
      def failures
        render json: { data: @vehicle.failures.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                       methods: %i[vehicle_license_plate user_email maintenance_plan_name]) },
               status: :ok
      end

      # Endpoint para monitoreo de combustible
      def fuel_records_monitoring
        render json: { data: RecordsMonitoringService.new(@vehicle).exec }
      end

      # Ver imagenes del vehiculo
      def images
        render json: { data: @vehicle.images.as_json(only: %i[id url]) }, status: :ok
      end

      # Ver documentos del vehiculo
      def documents
        render json: { data: @vehicle.documents.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state]) }, status: :ok
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
        @vehicles.as_json(only: %i[id license_plate driver_id], methods: %i[brand_name model_name state current_kms images_json fleet_name type_name])
      end

      # Generacion del JSON de salida para un vehiculo
      def show_json
        @vehicle.as_json(except: %i[manager_id created_at updated_at deleted_at state], methods: %i[brand_name model_name state current_kms images_json])
      end
    end
  end
end
