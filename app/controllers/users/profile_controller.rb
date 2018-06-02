class Users::ProfileController < ApplicationController

  before_action :find_user

  def edit;end

  def update
    if @user.update_attributes(profile_params)
      redirect_to request.referrer
      flash[:success] = 'Вы обновили профиль!'
    else
      flash[:error] = record_errors(@user)
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :email, :avatar, :password)
  end

  def find_user
    @user = current_user
  end
end
