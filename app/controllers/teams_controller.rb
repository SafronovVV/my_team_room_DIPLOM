class TeamsController < ApplicationController
  before_action :authorize_for_create!, only: [:new, :create]
  before_action :find_user
  before_action :authorize_for_update!, :find_team, only: [:edit, :update]

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

  def edit; end

  def update
    if @team.update(team_params)
      redirect_to root_path
      flash[:success] = 'Вы обновили команду!'
    else
      render 'edit'
      flash[:error] = record_errors(@team)
    end
  end

  private

  def find_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def find_user
    @user = current_user
  end

  def authorize_for_create!
    redirect_to root_path if current_user.joined_team?
  end

  def authorize_for_update!
    redirect_to root_path unless user_policy.able_to_edit_team?
  end
end
