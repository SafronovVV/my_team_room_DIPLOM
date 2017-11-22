class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :get_messages

  private

  def get_messages
    if user_signed_in? && current_user.chose_role? && current_user.joined_team?
      @messages = current_user.team.chat.messages
    end
  end

  def role_team_chosen?
    if user_signed_in?
      if current_user.chose_role? && current_user.joined_team?
        return
      else
        redirect_to edit_users_team_role_path(current_user)
      end
    end
  end
end
