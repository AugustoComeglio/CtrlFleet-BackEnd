# frozen_string_literal: true

module Api
  module V1
    class StateDocumentsController < Api::BaseController
      before_action :state_find_document, only: %i[show update destroy]

      def index
        @state_document = StateDocument.all

        render json: { data: @state_documents.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @state_document = StateDocument.new state_document_params

        if @state_document.save
          render json: { data: @state_document.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def show
        if @state_document
          render json: { data: @state_document.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Estado de Documento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def update
        if @state_document.update(state_document_params)
          render json: { data: @state_document.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @state_document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def destroy
        if @state_document.destroy
          render json: { message: 'Estado de Documento eliminado con exito' }, status: :ok
        else
          render json: { message: @state_document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      private

      def state_find_document
        @state_document = StateDocument.find_by id: params[:id]
      end

      def state_document_params
        params.require(:state_document).permit :name
      end
    end
  end
end
