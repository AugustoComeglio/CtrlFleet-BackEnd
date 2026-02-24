# frozen_string_literal: true

module Api
  module V1
    class UserTypesController < Api::BaseController
      before_action :find_user_type, only: %i[show update destroy users]

      def index
        @user_types = UserType.where.not(name: 'admin').order(:name)

        render json: { data: @user_types.as_json(only: %i[id name]) }, status: :ok
      end

      def create
        @user_type = UserType.new user_type_params
        @user_type.enable_login = true

        if @user_type.save
          render json: { data: @user_type.as_json(only: %i[id name], include: { permissions: { only: %i[id section action] } }) },
                 status: :ok
        else
          render json: { message: @user_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def show
        if @user_type
          render json: { data: @user_type.as_json(only: %i[id name], include: { permissions: { only: %i[id section action] } }) },
                 status: :ok
        else
          render json: { message: "No se encontro Tipo de Usuario con identificador #{params[:id]}" },
                 status: :not_found
        end
      end

      def update
        if @user_type.update user_type_params
          render json: { data: @user_type.as_json(only: %i[id name], include: { permissions: { only: %i[id section action] } }) },
                 status: :ok
        else
          render json: { message: @user_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def destroy
        if @user_type.destroy
          render json: { message: 'Tipo de Usuario eliminado con exito.' }, status: :ok
        else
          render json: { message: @user_type.errors.map { |e| e.options[:message] }.compact_blank.join(', ') }, status: :not_found
        end
      end

      def users
        render json: { data: @user_type.users.as_json(only: %i[id dni email first_name last_name phone],
                                                      methods: %i[type_name]) },
               status: :ok
      end

      def add_permission
        if @user_type
          if params[:permission_ids]
            result = params[:permission_ids].map do |id|
              UserTypePermission.find_or_create_by user_type_id: @user_type.id, permission_id: id
            end.flatten.uniq.first

            render json: { message: 'Ok' }, status: :ok if result
          end
        else
          render json: { message: "No se encontro Tipo de Usuario con identificador #{params[:id]}" },
                 status: :not_found
        end
      end

      def remove_permission
        if @user_type
          if params[:permission_ids]
            result = params[:permission_ids].map do |id|
              UserTypePermission.find_by(user_type_id: @user_type.id, permission_id: id).destroy
            end.flatten.uniq.first

            render json: { message: 'Ok' }, status: :ok if result
          end
        else
          render json: { message: "No se encontro Tipo de Usuario con identificador #{params[:id]}" },
                 status: :not_found
        end
      end

      private

      def find_user_type
        @user_type = UserType.find_by id: params[:id]
      end

      def user_type_params
        params.require(:user_type).permit :name, :enable_login
      end
    end
  end
end
