# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::BaseController
      before_action :find_user, only: %i[show update destroy documents permissions]

      def index
        @users = User.order(:first_name)

        render json: { data: @users.as_json(only: %i[id dni email first_name last_name phone],
                                            methods: %i[type_name photo]) },
               status: :ok
      end

      def create
        @user = User.new user_params

        if @user.save
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name photo]) },
                 status: :ok
        else
          render json: { message: @user.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        if @user
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name photo]) },
                 status: :ok
        else
          render json: { message: "No se encontro Usuario con ID #{params[:id]}" }, status: :not_found
        end
      end

      def update
        if @user.update user_params
          render json: { data: @user.as_json(only: %i[id dni email first_name last_name phone],
                                             methods: %i[type_name photo]) },
                 status: :ok
        else
          render json: { message: @user.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        render json: { message: 'No puede eliminar a un administrador de sistema' }, status: :ok and return if @user.role?('admin')

        if @user.destroy
          render json: { message: 'Usuario eliminado con exito' }, status: :ok
        else
          render json: { message: @user.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def documents
        render json: { data: @user.documents.as_json(except: %i[created_at updated_at deleted_at], methods: %i[state]) }, status: :ok
      end

      def permissions
        render json: { data: @user.type.permissions.as_json(only: %i[section action]) }, status: :ok
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
