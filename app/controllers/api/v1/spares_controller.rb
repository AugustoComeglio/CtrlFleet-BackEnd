# frozen_string_literal: true

module Api
  module V1
    class SparesController < Api::BaseController
      before_action :find_spare, only: %i[show update destroy images]

      def index
        @spares = Spare.all.order(:name)

        render json: { data: @spares.as_json(only: %i[id name brand_id], methods: %i[count_in_stock brand_name images_json]) }, status: :ok
      end

      def availables
        @spares = Spare.in_stock.order(:name)

        render json: { data: @spares.as_json(only: %i[id name brand_id], methods: %i[total_count brand_name images_json]) }, status: :ok
      end

      def show
        if @spare
          render json: { data: @spare.as_json(only: %i[id name brand_id], methods: %i[count_in_stock brand_name images_json]) }, status: :ok
        else
          render json: { message: "Repuesto #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @spare = Spare.new spare_params

        if @spare.save
          render json: { data: @spare.as_json(only: %i[id name brand_id], methods: %i[count_in_stock brand_name images_json]) }, status: :ok
        else
          render json: { message: @spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @spare.update spare_params
          render json: { data: @spare.as_json(only: %i[id name brand_id], methods: %i[count_in_stock brand_name images_json]) }, status: :ok
        else
          render json: { message: @spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @spare.destroy
          render json: { message: 'Repuesto eliminado con exito' }, status: :ok
        else
          render json: { message: @spare.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_spare
        @spare = Spare.find_by id: params[:id]
      end

      def spare_params
        params.require(:spare).permit :name, :brand_id
      end
    end
  end
end
