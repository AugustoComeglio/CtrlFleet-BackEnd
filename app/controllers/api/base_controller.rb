# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    load_and_authorize_resource

    before_action :require_current_user

    def current_user
      return nil unless doorkeeper_token
      return @current_user if @current_user

      doorkeeper_authorize!

      @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
    end

    delegate :id, to: :current_user, prefix: true

    def require_current_user
      return true unless current_user.nil?

      render json: { message: 'Usuario NO autorizado!' }, status: :forbidden
    end
  end
end
