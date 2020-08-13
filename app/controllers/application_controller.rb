# frozen_string_literal: true

# Application Controller of RepApp
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :name, :password, :current_password) }
  end

  def authorize_admin
    redirect_to(home_index_path, notice: 'Not Allowed') and return unless current_user.has_role? :admin
    flash[:notice]
  end

  
end
