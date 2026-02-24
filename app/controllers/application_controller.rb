class ApplicationController < ActionController::API
  # Render Custom message to exception CanCan::AccessDenied
  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: 'Acceso Denegado. Usuario No Autorizado.' }, status: :forbidden
  end
end
