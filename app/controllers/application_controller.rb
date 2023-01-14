class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pundit
  #  include Security::SecurityOperation
  include Cache::RedisCache
  include Log::FileLogger
  include CustomError::ErrorHandler

  def user_not_authorized
    @message = "Not auth"
    render json: {message: @message}, status:401
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :password, :password_confirmation])
  end

end
