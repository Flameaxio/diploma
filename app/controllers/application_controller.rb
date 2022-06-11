# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery prepend: true

  before_action :authenticate_user!
  before_action :set_current_user_json
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_user_json
    return if current_user.blank?

    @current_user_json = UserBriefSerializer.new(current_user).serializable_hash[:data][:attributes].to_json
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :middle_name)
    end
  end
end
