# frozen_string_literal: true

module Api
  module V1
    class StockMovementSparesController < Api::BaseController
      before_action :find_stock_movement_spare, only: %i[update destroy]

      def create
        spare_warehouse = SpareWarehouse.find_or_initialize_by(spare_id: stock_movement_spare_params[:spare_id],
                                                               warehouse_id: stock_movement_spare_params[:warehouse_id])

        spare_warehouse.save if spare_warehouse.valid?

        if stock_movement_spare_params[:quantity].positive? || (spare_warehouse.quantity >= (stock_movement_spare_params[:quantity] * -1))
          @stock_movement_spare = StockMovementSpare.new(quantity: stock_movement_spare_params[:quantity],
                                                         spare_warehouse_id: spare_warehouse.id)
        end

        if @stock_movement_spare.save
          render json: { message: 'Movimiento de Stock creado con exito' }, status: :ok
        else
          render json: { message: @stock_movement_spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @stock_movement_spare.update(stock_movement_spare_params)
          render json: { message: 'Movimiento de Stock actualizado con exito' }, status: :ok
        else
          render json: { message: @stock_movement_spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @stock_movement_spare.destroy
          render json: { message: 'Movimiento de Stock eliminado con exito' }, status: :ok
        else
          render json: { message: @stock_movement_spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_stock_movement_spare
        @stock_movement_spare = StockMovementSpare.find_by id: params[:id]
      end

      def stock_movement_spare_params
        params.require(:stock_movement).permit :spare_id, :warehouse_id, :quantity
      end
    end
  end
end
