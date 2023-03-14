class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_user
  rescue_from Banken::NotAuthorizedError, with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:passwrod,:phone,:address,:birthday,:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  end

  def not_authorized
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
