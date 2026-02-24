# frozen_string_literal: true

module Api
  module V1
    class ModelsController < Api::BaseController
      def index
        @models = if params[:brand_id]
                    Model.where(brand_id: params[:brand_id]).order(:name)
                  else
                    Model.all.order(:name)
                  end

        render json: { data: @models.as_json(only: %i[id name], methods: %i[brand_name]) }, status: :ok
      end

      def create
        @model = Model.new model_params

        if @model.save
          render json: { data: @model.as_json(only: %i[id name], methods: %i[brand_name]) }, status: :ok
        else
          render json: { message: @model.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        @model = Model.find_by id: params[:id]

        if @model
          render json: { data: @model.as_json(only: %i[id name], methods: %i[brand_name]) }, status: :ok
        else
          render json: { message: "No se encontro un Modelo con identificador #{params[:id]}" }, status: :not_found
        end
      end

      def update
        @model = Model.find_by id: params[:id]

        if @model.update model_params
          render json: { data: @model.as_json(only: %i[id name], methods: %i[brand_name]) }, status: :ok
        else
          render json: { message: @model.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        @model = Model.find_by id: params[:id]

        if @model.destroy
          render json: { message: 'Modelo eliminado con exito' }, status: :ok
        else
          render json: { message: @model.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def model_params
        params.require(:model).permit :name, :brand_id
      end
    end
  end
end
