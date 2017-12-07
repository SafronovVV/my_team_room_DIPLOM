class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :get_messages
  before_action :configure_permitted_parameters, if: :devise_controller?

  def record_errors(model)
    model.errors.full_messages.to_s.tr('[]""', '')
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
  end

  def get_messages
    if user_signed_in? && current_user.chose_role? && current_user.joined_team?
      @messages = current_user.team.chat.messages
    end
  end

  def registration_completed?
    redirect_to edit_users_team_role_path(current_user) unless current_user.completed_registration?
  end
end
