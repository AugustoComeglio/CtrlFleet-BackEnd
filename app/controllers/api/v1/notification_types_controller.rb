# frozen_string_literal: true

module Api
  module V1
    class NotificationTypesController < Api::BaseController
      before_action :find_notification_type

      def index
        @notification_types = NotificationType.all.order(:name)

        render json: { data: @notification_types.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @notification_type = NotificationType.new(notification_type_params)

        if @notification_type.save
          render json: { data: @notification_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @notification_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def show
        if @notification_type
          render json: { data: @notification_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: "Tipo de Notificacion con ID #{params[:id]} no encontrado" },
                 status: :not_found
        end
      end

      def update
        if @notification_type.update notification_type_params
          render json: { data: @notification_type.as_json(only: %i[id name]) }, status: :ok
        else
          render json: { message: @notification_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      def destroy
        if @notification_type.destroy
          render json: { message: 'Tipo de Notificacion eliminado con exito' }, status: :ok
        else
          render json: { message: @notification_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      private

      def find_notification_type
        @notification_type = NotificationType.find_by id: params[:id]
      end

      def notification_type_params
        params.require(:notification_type).permit :name
      end
    end
  end
end
