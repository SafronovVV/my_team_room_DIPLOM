class Users::JoinTeamsController < ApplicationController
  before_action :authorize!
  before_action :find_user

  def new
    @teams = Team.where.not(captain_id: nil)
  end

  def create
    @team = Team.find(params[:id])
    if @user.update_attributes(chose_role: true)
      @team.users << @user
      redirect_to static_screens_expect_invitation_path
    else
      render 'new'
      flash[:error] = record_errors(@user)
    end
  end

  private
  def authorize!
    redirect_to root_path if user_policy.joined_team?
  end

  def find_user
    @user = current_user
  end
end
