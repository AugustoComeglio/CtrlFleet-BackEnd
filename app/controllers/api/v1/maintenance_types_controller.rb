# frozen_string_literal: true

module Api
  module V1
    class MaintenanceTypesController < Api::BaseController
      before_action :find_maintenance_type, only: %i[show update destroy]

      def index
        @maintenance_type = MaintenanceType.all.order(:name)

        render json: { data: @maintenance_types.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @maintenance_type = MaintenanceType.new maintenance_type_params

        if @maintenance_type.save
          render json: { data: @maintenance_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @maintenance_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def show
        if @maintenance_type
          render json: { data: @maintenance_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Tipo de Mantenimiento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @maintenance_type.update(maintenance_type_params)
          render json: { data: @maintenance_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @maintenance_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def destroy
        if @maintenance_type.destroy
          render json: { message: 'Tipo de Mantenimiento eliminado con exito' }, status: :ok
        else
          render json: { message: @maintenance_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      private

      def find_maintenance_type
        @maintenance_type = MaintenanceType.find_by id: params[:id]
      end

      def maintenance_type_params
        params.require(:maintenance_type).permit :name
      end
    end
  end
end
