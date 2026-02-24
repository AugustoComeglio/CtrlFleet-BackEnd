# frozen_string_literal: true

module Api
  module V1
    class ImagesController < Api::BaseController
      before_action :find_image, only: %i[show update destroy]

      def index
        @images = Image.all

        render json: { data: @images.as_json(only: %i[id url user_id vehicle_id spare_id failure_id]) }, status: :ok
      end

      def show
        if @image
          render json: { data: @image.as_json(only: %i[id url user_id vehicle_id spare_id failure_id]) }, status: :ok
        else
          render json: { message: "Imagen #{params[:id]} no encontrada" }, status: :not_found
        end
      end

      def create
        @image = Image.new image_params
        @image.manager_id = current_user_id

        if @image.save
          render json: { data: @image.as_json(only: %i[id url user_id vehicle_id spare_id failure_id]) }, status: :ok
        else
          render json: { message: @image.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @image.update image_params
          render json: { data: @image.as_json(only: %i[id url user_id vehicle_id spare_id failure_id]) }, status: :ok
        else
          render json: { message: @image.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @image.destroy
          render json: { message: 'Imagen eliminada con exito' }, status: :ok
        else
          render json: { message: @image.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_image
        @image = Image.find_by id: params[:id]
      end

      def image_params
        params.require(:image).permit :url, :user_id, :vehicle_id, :spare_id, :failure_id
      end
    end
  end
end
