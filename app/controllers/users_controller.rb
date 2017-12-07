class UsersController < ApplicationController

  before_action :find_user
  before_action :restrict_view

  def show;end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def restrict_view
    redirect_back fallback_location: root_path if current_user.team != @user.team
  end
end
