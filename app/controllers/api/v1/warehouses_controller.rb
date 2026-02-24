# frozen_string_literal: true

module Api
  module V1
    class WarehousesController < Api::BaseController
      before_action :find_warehouse, only: %i[show update destroy]

      def index
        @warehouses = Warehouse.all.order(:name)

        render json: { data: @warehouses.as_json(only: %i[id name code location]) }, status: :ok
      end

      def show
        if @warehouse
          render json: { data: @warehouse.as_json(only: %i[id name code location]) }, status: :ok
        else
          render json: { message: "Deposito #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @warehouse = Warehouse.new warehouse_params

        if @warehouse.save
          render json: { data: @warehouse.as_json(only: %i[id name code location]) }, status: :ok
        else
          render json: { message: @warehouse.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @warehouse.update warehouse_params
          render json: { data: @warehouse.as_json(only: %i[id name code location]) }, status: :ok
        else
          render json: { message: @warehouse.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @warehouse.destroy
          render json: { message: 'Deposito eliminado con exito' }, status: :ok
        else
          render json: { message: @warehouse.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_warehouse
        @warehouse = Warehouse.find_by id: params[:id]
      end

      def warehouse_params
        params.require(:warehouse).permit :name, :location, :code
      end
    end
  end
end
