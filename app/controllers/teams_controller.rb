class TeamsController < ApplicationController
  before_action :authorize_for_create!, only: [:new, :create]
  before_action :find_user
  before_action :authorize_for_update!, :find_team, only: [:edit, :update, :perform_invitation]

  def new
    @team = @user.teams.new
  end

  def create
    @team = @user.teams.new(team_params.merge(captain_id: @user.id))
    if @team.save
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

  def perform_invitation
    puts params[:invite]
    @applicant = User.find(params[:user_id])
    if params[:invite] == "true"
      if @applicant.update(joined_team: true)
        redirect_to request.referrer
        flash[:success] = 'Вы добавили пользователя!'
      else
        render 'edit'
        flash[:error] = record_errors(@applicant)
      end
    else
      @applicant.teams.delete(@team)
      @team.users.delete(@applicant)
      flash[:success] = 'Вы отклонили заявку!'
      render 'edit'
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
