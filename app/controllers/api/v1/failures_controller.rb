# frozen_string_literal: true

module Api
  module V1
    class FailuresController < Api::BaseController
      before_action :find_failure, only: %i[show update destroy images]

      def index
        @failures = Failure.all.order(:name)

        render json: { data: @failures.as_json(only: %i[id name description], methods: %i[vehicle_license_plate images_json]) }, status: :ok
      end

      def show
        if @failure
          render json: { data: @failure.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                methods: %i[vehicle_license_plate images_json maintenance_plan_name]) },
                 status: :ok
        else
          render json: { message: "Daño #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @failure = Failure.new failure_params
        @failure.user_id = current_user_id

        if @failure.save
          @failure.vehicle.change_state!('dañado')

          render json: { data: @failure.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                methods: %i[vehicle_license_plate images_json maintenance_plan_name]) },
                 status: :ok
        else
          render json: { message: @failure.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @failure.update failure_params
          render json: { data: @failure.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                methods: %i[vehicle_license_plate images_json maintenance_plan_name]) },
                 status: :ok
        else
          render json: { message: @failure.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @failure.destroy
          @failure.vehicle.change_state!('activo')

          render json: { message: 'Daño eliminado con exito' }, status: :ok
        else
          render json: { message: @failure.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def images
        render json: { data: @failure.images.as_json(only: %i[id url]) }, status: :ok
      end

      def documents
        render json: { data: @failure.documents.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state]) }, status: :ok
      end

      private

      def find_failure
        @failure = Failure.find_by id: params[:id]
      end

      def failure_params
        params.require(:failure).permit :name, :description, :priority, :maintenance_plan_id, :vehicle_id
      end
    end
  end
end
