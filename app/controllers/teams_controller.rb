class TeamsController < ApplicationController

  before_action :restrict_team
  before_action :find_user

  def new
    @team = @user.teams.new
  end

  def create
    @team = @user.teams.new(team_params)
    @team.captain_id = @user.id
    if @team.save && @team.users << @user
      @chat = Chat.create!(team_id: @team.id)
      @user.update(joined_team: true, chose_role: true)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.users << @user
      @user.update_attributes(joined_team: true, chose_role: true)
      redirect_to root_path
    else
      render 'index'
    end
  end

  def index
    @teams = Team.all
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def find_user
    @user = current_user
  end

  def restrict_team
    redirect_to root_path if current_user.joined_team?
  end
end
