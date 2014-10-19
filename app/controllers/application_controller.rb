class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :identifier,
        :email,
        :password,
        :password_confirmation,
        :remember_me
      )
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(
        :login,
        :identifier,
        :email,
        :password,
        :remember_me
      )
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :identifier,
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    end
  end
end
