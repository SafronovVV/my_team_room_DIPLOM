class Users::TeamRolesController < ApplicationController
  before_action :authorize!
  before_action :find_user, only: [:edit, :update]

  def edit;end

  def update
    if @user.update_attributes(user_params)
      if @user.team_role == 'captain'
        redirect_to new_team_path
      else
        redirect_to new_users_join_team_path
      end
    else
      render 'edit'
    end
  end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:team_role)
  end

  def authorize!
    redirect_to root_path if user_policy.chose_role?
  end
end
