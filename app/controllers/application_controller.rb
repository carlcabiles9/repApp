# frozen_string_literal: true

# Application Controller of RepApp
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :run

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :name, :password, :current_password) }
  end

  def authorize_admin
    redirect_to(home_index_path, notice: 'Not Allowed') and return unless current_user.has_role? :admin
    flash[:notice]
  end

  def run
    if user_signed_in?
      if current_user.recipients.blank?
        flash[:alert] = 'No email recipients yet'
      else
        if Date.today.monday?
          User.find(current_user.id).recipients.each do |recipient|
            mail_opts = { to: recipient.email }
            reports = current_user.reports.where(created_at: Date.today.beginning_of_week..Date.today.end_of_week)
            UserMailer.email_report(current_user, reports, mail_opts).deliver_later
          end
        end
      end

    end
  end
end
