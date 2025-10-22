# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::BaseController
      before_action :find_user, only: %i[show update destroy]

      def index
        @users = User.all

        render json: { data: @users.as_json(only: %i[id dni email first_name last_name phone],
                                            methods: %i[type_name]) },
               status: :ok
      end

      def create
        @user = User.new user_params

        if @user.save
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name]) },
                 status: :ok
        else
          render json: { message: @user.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      def show
        if @user
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name]) },
                 status: :ok
        else
          render json: { message: "No se encontro Usuario con ID #{params[:id]}" }, status: :not_found
        end
      end

      def update
        if @user.update user_params
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name]) },
                 status: :ok
        else
          render json: { message: @user.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @user.destroy
          render json: { message: 'Usuario eliminado con exito' }, status: :ok
        else
          render json: { message: @user.errors.full_messages.join(', ') }, status: :not_found
        end
      end

      private

      def find_user
        @user = User.find_by id: params[:id]
      end

      def user_params
        params.require(:user).permit :dni, :email, :first_name, :last_name, :phone, :password,
                                     :password_confirmation, :user_type_id
      end
    end
  end
end
