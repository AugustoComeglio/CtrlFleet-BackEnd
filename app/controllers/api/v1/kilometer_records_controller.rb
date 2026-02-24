# frozen_string_literal: true

module Api
  module V1
    class KilometerRecordsController < Api::BaseController
      before_action :find_kilometer_record, only: %i[show update]

      def index
        @kilometer_records = KilometerRecord.all.order(:registered_at)

        render json: { data: @kilometer_records.as_json(except: %i[unit_id created_at updated_at deleted_at],
                                                        methods: %i[vehicle_hash unit_name]) },
               status: :ok
      end

      def show
        if @kilometer_record
          render json: { data: @kilometer_record.as_json(except: %i[created_at updated_at deleted_at],
                                                         methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: "Registro de Carga de Kilometros #{params[:id]} no encontrada" }, status: :not_found
        end
      end

      def create
        @kilometer_record = KilometerRecord.new kilometer_record_params

        if @kilometer_record.save
          render json: { data: @kilometer_record.as_json(except: %i[created_at updated_at deleted_at],
                                                        methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: @kilometer_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @kilometer_record.update kilometer_record_params
          render json: { data: @kilometer_record.as_json(except: %i[created_at updated_at deleted_at],
                                                         methods: %i[vehicle_hash]) },
                 status: :ok
        else
          render json: { message: @kilometer_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @kilometer_record.destroy
          render json: { message: 'Registro de Kilometros eliminado con exito.' }, status: :ok
        else
          render json: { message: @kilometer_record.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_kilometer_record
        @kilometer_record = KilometerRecord.find_by id: params[:id]
      end

      def kilometer_record_params
        params.require(:kilometer_record).permit :kms_traveled, :observation, :vehicle_id, :unit_id, :registered_at
      end
    end
  end
end
