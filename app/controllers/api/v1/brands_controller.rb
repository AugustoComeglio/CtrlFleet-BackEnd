# frozen_string_literal: true

module Api
  module V1
    class BrandsController < Api::BaseController
      before_action :find_brand, only: %i[show update destroy models]

      def index
        @brands = Brand.order(:name)

        render json: { data: index_json }, status: :ok
      end

      def show
        if @brand
          render json: { data: show_json }, status: :ok
        else
          render json: { message: "No se encontro una Marca con el identificador #{params[:id]}" }, status: :not_found
        end
      end

      def create
        @brand = Brand.new brand_params

        if @brand.save
          render json: { data: show_json }, status: :ok
        else
          render json: { message: @brand.errors.map { |e| e.options[:message]}.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @brand.update brand_params
          render json: { data: show_json }, status: :ok
        else
          render json: { message: @brand.errors.map { |e| e.options[:message]}.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @brand.destroy
          render json: { message: 'Marca eliminada con exito' }, status: :ok
        else
          render json: { message: @brand.errors.map { |e| e.options[:message]}.compact_blank.join(', ') }, status: :not_found
        end
      end

      def models
        render json: { data: @brand.models.order(:name).as_json(only: %i[id name]) }, status: :ok
      end

      private

      def find_brand
        @brand = Brand.find_by id: params[:id]
      end

      def brand_params
        params.require(:brand).permit :name
      end

      def index_json
        @brands.as_json only: %i[id name], include: { models: { only: %i[id name] } }
      end

      def show_json
        @brand.as_json only: %i[id name], include: { models: { only: %i[id name] } }
      end
    end
  end
end
