# frozen_string_literal: true

module Api
  module V1
    class StateMaintenancesController < Api::BaseController
      before_action :state_find_maintenance, only: %i[show update destroy]

      def index
        @state_maintenance = StateMaintenance.all

        render json: { data: @state_maintenances.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @state_maintenance = StateMaintenance.new state_maintenance_params

        if @state_maintenance.save
          render json: { data: @state_maintenance.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def show
        if @state_maintenance
          render json: { data: @state_maintenance.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Estado de Mantenimiento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @state_maintenance.update(state_maintenance_params)
          render json: { data: @state_maintenance.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def destroy
        if @state_maintenance.destroy
          render json: { message: 'Estado de Mantenimiento eliminado con exito' }, status: :ok
        else
          render json: { message: @state_maintenance.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      private

      def state_find_maintenance
        @state_maintenance = StateMaintenance.find_by id: params[:id]
      end

      def state_maintenance_params
        params.require(:state_maintenance).permit :name
      end
    end
  end
end
