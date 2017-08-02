class ApplicationController < ActionController::Base 
 protect_from_forgery with: :exception 
 
 protected
 
   def configure_permitted_parameters

      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :about, :email, :password, :current_password, :avatar) }
    end
end

