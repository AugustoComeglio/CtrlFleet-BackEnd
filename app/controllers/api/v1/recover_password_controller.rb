# frozen_string_literal: true

module Api
  module V1
    class RecoverPasswordController < ApplicationController
      before_action :require_params_reset_password, only: :create
      before_action :require_params_change_password, only: :update

      def create
        user = User.find_by email: params[:email]

        if user
          user.send_reset_password_instructions

          if user.reset_password_token
            render json: { message: 'En unos minutos recibirás un correo electrónico con instrucciones sobre cómo recuperar tu cuenta' },
                   status: :ok
          else
            render json: { message: 'Error Inesperado no pudimos enviar correo.' }, status: :internal_server_error
          end
        else
          render json: { message: 'Usuario no encontrado.' },
                 status: :not_found
        end
      end

      def update
        user = User.reset_password_by_token(
          {
            reset_password_token: params[:reset_password_token],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          }
        )

        if user.valid?
          render_payload_with_token(user)
        else
          render json: { message: "No se ha podido reestablecer la contraseña.
                                  #{user.errors.map { |e| e.options[:message] }.compact_blank.join(', ')}" },
                 status: :unprocessable_entity
        end
      end

      private

      def require_params_reset_password
        render json: { message: 'Faltan Parametros' }, status: :internal_server_error unless params[:email]
      end

      def require_params_change_password
        return if %i[reset_password_token password password_confirmation].all? { |s| params.key? s }

        render json: { message: 'Faltan Parametros' }, status: :internal_server_error
      end

      def render_payload_with_token(user)
        if user.valid?
          access_token = user.get_doorkeeper_token

          render json: { message: 'La contraseña de tu cuenta ha sido verificada correctamente.',
                         access_token: access_token.token, token_type: 'bearer', expires_in: access_token.expires_in,
                         refresh_token: access_token.refresh_token, created_at: access_token.created_at.to_time.to_i,
                         user_data: { id: user.id, email: user.email, type: user.type_name, photo: user.photo } },
                 status: :ok
        else
          render json: { message: "No se ha podido reestablecer la contraseña.
                                  #{user.errors.map { |e| e.options[:message] }.compact_blank.join(', ')}" },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
