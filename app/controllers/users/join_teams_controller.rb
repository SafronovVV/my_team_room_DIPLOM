class Users::JoinTeamsController < ApplicationController
  before_action :find_user

  def new
    @teams = Team.where.not(captain_id: nil)
  end

  def create
    @team = Team.find(params[:id])
    if @user.update_attributes(joined_team: true, chose_role: true)
      @team.users << @user
      flash[:success] = 'You joined a team!'
      redirect_to root_path
    else
      render 'new'
      flash[:error] = record_errors(@user)
    end
  end

  private

  def find_user
    @user = current_user
  end
end
