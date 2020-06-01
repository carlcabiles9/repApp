class ApplicationController < ActionController::Base

     before_action :authenticate_user!
     
     protect_from_forgery with: :exception
     before_action :configure_permitted_parameters, if: :devise_controller?

     protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :name, :password, :current_password)}
          end

     def run
          if Date.today.monday?
           User.find_each do |user| 
               UserMailer.with(user: user).email_report.deliver_later
          end
     end

     end
     
    
end