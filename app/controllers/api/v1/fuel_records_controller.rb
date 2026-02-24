# frozen_string_literal: true

module Api
  module V1
    class FuelRecordsController < Api::BaseController
      before_action :find_fuel_record, only: %i[show update]

      def index
        @fuel_records = FuelRecord.all.order(:registered_at)

        render json: { data: @fuel_records.as_json(except: %i[vehicle_id unit_id gas_station_id created_at updated_at deleted_at],
                                                   methods: %i[vehicle_hash gas_station_name unit_name]) },
               status: :ok
      end

      def show
        if @fuel_record
          render json: { data: @fuel_record.as_json(except: %i[vehicle_id created_at updated_at deleted_at],
                                                    methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: "Registro de Carga de Combustible #{params[:id]} no encontrada" }, status: :not_found
        end
      end

      def create
        @fuel_record = FuelRecord.new fuel_record_params

        if @fuel_record.save
          render json: { data: @fuel_record.as_json(except: %i[vehicle_id created_at updated_at deleted_at],
                                                    methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: @fuel_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @fuel_record.update fuel_record_params
          render json: { data: @fuel_record.as_json(except: %i[vehicle_id created_at updated_at deleted_at],
                                                    methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: @fuel_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @fuel_record.destroy
          render json: { message: 'Registro de Combustible eliminado con exito.' }, status: :ok
        else
          render json: { message: @fuel_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_fuel_record
        @fuel_record = FuelRecord.find_by id: params[:id]
      end

      def fuel_record_params
        params.require(:fuel_record).permit :quantity, :unit_price, :vehicle_id, :gas_station_id, :unit_id,
                                            :fuel_type_id, :observation, :registered_at
      end
    end
  end
end
