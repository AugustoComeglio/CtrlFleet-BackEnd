# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < Api::BaseController
      before_action :find_notification, only: %i[show update]

      def index
        @notifications = Notification.where(user_id: current_user_id).order(created_at: :desc)

        render json: { data: @notifications.as_json(only: %i[id user_id title message record_id record_type viewed_at]) }, status: :ok
      end

      def show
        if @notification
          render json: { data: @notification.as_json(only: %i[id title message record_id record_type viewed_at]) }, status: :ok
        else
          render json: { message: "Tipo de Notificacion con ID #{params[:id]} no encontrado" },
                 status: :not_found
        end
      end

      def update
        if @notification.update notification_params
          render json: { data: @notification.as_json(only: %i[id user_id title message record_id record_type viewed_at]) }, status: :ok
        else
          render json: { message: @notification.errors.map { |e| e.options[:message] }.compact_blank.join(', ') },
                 status: :not_found
        end
      end

      private

      def find_notification
        @notification = Notification.find_by id: params[:id]
      end

      def notification_params
        params.require(:notification).permit :user_id, :viewed_at
      end
    end
  end
end
