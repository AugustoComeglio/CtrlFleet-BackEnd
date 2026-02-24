# frozen_string_literal: true

module Api
  module V1
    class EnableNotificationTypesController < Api::BaseController
      before_action :enable_find_notification_type, only: :update

      def index
        @enable_notification_types = EnableNotificationType.where(user_id: current_user_id)

        render json: { data: @enable_notification_types.as_json(only: %i[id enable], methods: %i[notification_type_name]) }, status: :ok
      end

      def create
        @enable_notification_type = EnableNotificationType.find_or_initialize_by enable_notification_type_params
        @enable_notification_type.user_id = current_user_id

        if @enable_notification_type.save
          render json: { message: "Tipo de Notificacion #{enable_notification_type_params[:enable] ? 'Habilitada' : 'Deshabilitada'} correctamente" }, status: :ok
        else
          render json: { message: @enable_notification_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def update
        if @enable_notification_type.update enable_notification_type_params
          render json: { message: "Tipo de Notificacion #{enable_notification_type_params[:enable] ? 'Habilitada' : 'Deshabilitada'} correctamente" }, status: :ok
        else
          render json: { message: @enable_notification_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      private

      def enable_find_notification_type
        @enable_notification_type = EnableNotificationType.find_by id: params[:id]
      end

      def enable_notification_type_params
        params.require(:enable_notification_type).permit :enable, :notification_type_id
      end
    end
  end
end
