# frozen_string_literal: true

module Api
  module V1
    class MaintenancePlansController < Api::BaseController
      before_action :find_maintenance_plan, except: %i[index create]

      def index
        @maintenance_plan = MaintenancePlan.all.order(:begin_at)

        render json: { data: @maintenance_plans.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @maintenance_plan = MaintenancePlan.new maintenance_plan_params
        @maintenance_plan.user_id = current_user_id

        if @maintenance_plan.save
          render json: { data: @maintenance_plan.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @maintenance_plan.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def show
        if @maintenance_plan
          render json: { data: @maintenance_plan.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Plan de Mantenimiento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @maintenance_plan.update(maintenance_plan_params)
          render json: { data: @maintenance_plan.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @maintenance_plan.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def destroy
        if @maintenance_plan.destroy
          render json: { message: 'Plan de Mantenimiento eliminado con exito' }, status: :ok
        else
          render json: { message: @maintenance_plan.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def maintenances
        render json: { data: @maintenance_plan.maintenances.order(:priority).as_json(except: %i[user_id created_at updated_at deleted_at], methods: %i[state vehicle_license_plate]) },
               status: :ok
      end

      def failures
        render json: { data: @maintenance_plan.failures.as_json(except: %i[user_id created_at updated_at deleted_at],
                                                                methods: %i[vehicle_license_plate user_email maintenance_plan_name]) },
               status: :ok
      end

      private

      def find_maintenance_plan
        @maintenance_plan = MaintenancePlan.find_by id: params[:id]
      end

      def maintenance_plan_params
        params.require(:maintenance_plan).permit :name
      end
    end
  end
end
