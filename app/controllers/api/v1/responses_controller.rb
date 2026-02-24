# frozen_string_literal: true

module Api
  module V1
    class ResponsesController < Api::BaseController
      before_action :find_response, only: %i[show update destroy units]

      def index
        @responses = Response.all.order(:created_at)

        render json: { data: @responses.as_json(only: %i[id details], methods: %i[user_email]) }, status: :ok
      end

      def show
        if @response
          render json: { data: @response.as_json(only: %i[id details], methods: %i[user_email]) }, status: :ok
        else
          render json: { message: "Respuesa de Debate #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @response = Response.new response_params
        @response.user_id = current_user_id

        if @response.save
          render json: { data: @response.as_json(only: %i[id details], methods: %i[user_email]) }, status: :ok
        else
          render json: { message: @response.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @response.update response_params
          render json: { data: @response.as_json(only: %i[id details], methods: %i[user_email]) }, status: :ok
        else
          render json: { message: @response.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @response.destroy
          render json: { message: 'Respuesta de Debate eliminado con exito' }, status: :ok
        else
          render json: { message: @response.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_response
        @response = Response.find_by id: params[:id]
      end

      def response_params
        params.require(:response).permit :details, :debate_id
      end
    end
  end
end
