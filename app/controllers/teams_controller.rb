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
      flash[:success] = 'Вы создали команду!'
      redirect_to root_path
    else
      flash[:error] = record_errors(@team)
      render 'new'
    end
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
