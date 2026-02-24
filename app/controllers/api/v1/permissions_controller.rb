# frozen_string_literal: true

module Api
  module V1
    class PermissionsController < Api::BaseController
      before_action :find_permission, only: %i[show update destroy]

      def index
        @permissions = Permission.all.order(:section)

        render json: { data: @permissions.as_json(only: %i[id section action]) }, status: :ok
      end

      def show
        if @permission
          render json: { data: @permission.as_json(only: %i[id section action]) }, status: :ok
        else
          render json: { message: "Permiso #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @permission = Permission.new permission_params

        if @permission.save
          render json: { data: @permission.as_json(only: %i[id section action]) }, status: :ok
        else
          render json: { message: @permission.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @permission.update permission_params
          render json: { data: @permission.as_json(only: %i[id section action]) }, status: :ok
        else
          render json: { message: @permission.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @permission.destroy
          render json: { message: 'Permiso eliminado con exito' }, status: :ok
        else
          render json: { message: @permission.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_permission
        @permission = Permission.find_by id: params[:id]
      end

      def permission_params
        params.require(:permission).permit :name, :section, :action
      end
    end
  end
end
