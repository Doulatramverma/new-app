class Api::V1::RegistrationsController < ApplicationController
  # skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create

    user = User.new(user_params)

    if user.save
      render :json => user.as_json(:auth_token=>user.id, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  def login
    if params[:registration][:email] && params[:registration][:password]
      @user = User.where(email: params[:email]).first
      if @user && @user.valid_password?(params[:registration][:password])
        sign_in :user, @user    
        render status: 200, json: { success: true, message: "Login done", email: @user.email, id: @user.id }    
      else
        render status: 401, json: { success: false, message: 'Invalid email or password.' }
      end
    else
      render status: 401, json: { success: false, message: 'Invalid email or password.' }
    end
  end
     
  def logout
    sign_out(current_user)
    render status: 200, json: { success: 'logout', message: 'logout successfully' }
  end

  
  private

  def user_params
    params.require(:registration).permit(:email, :password)
  end
end
