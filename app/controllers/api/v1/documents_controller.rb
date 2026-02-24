# frozen_string_literal: true

module Api
  module V1
    class DocumentsController < Api::BaseController
      before_action :find_document, only: %i[show update destroy]

      def index
        @documents = Document.all

        render json: { data: @documents.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state failure_name user_email vehicle_license_plate]) }, status: :ok
      end

      def show
        if @document
          render json: { data: @document.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state failure_name user_email vehicle_license_plate]) }, status: :ok
        else
          render json: { message: "Documento #{params[:id]} no encontrado" }, status: :not_found
        end
      end

      def create
        @document = Document.new document_params
        @document.manager_id = current_user_id

        if @document.save
          render json: { data: @document.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state failure_name user_email vehicle_license_plate]) }, status: :ok
        else
          render json: { message: @document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @document.update document_params
          render json: { data: @document.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state failure_name user_email vehicle_license_plate]) }, status: :ok
        else
          render json: { message: @document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @document.delete
          render json: { message: 'Documento eliminado con exito' }, status: :ok
        else
          render json: { message: @document.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def find_document
        @document = Document.find_by id: params[:id]
      end

      def document_params
        params.require(:document).permit :title, :url, :expires_in, :user_id, :vehicle_id, :failure_id
      end
    end
  end
end
