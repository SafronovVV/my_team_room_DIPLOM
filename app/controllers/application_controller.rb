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
    if user_policy.fully_registered?
      @messages = current_user.team.chat.messages
    end
  end

  def user_policy
    @user_policy ||= UserPolicy.new(current_user)
  end

  def global_accessibility
    redirect_to select_path unless user_policy.fully_registered?
  end

  def select_path
    if !user_policy.chose_role?
      edit_users_team_role_path(current_user)
    elsif user_policy.not_joined_team?
      new_users_join_team_path
    elsif user_policy.expect_invitation?
      static_screens_expect_invitation_path
    end
  end

  helper_method :user_policy
end
