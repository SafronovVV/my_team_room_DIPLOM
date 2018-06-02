class Users::SettingsController < ApplicationController
  before_action :find_user

  def update
    redirect_to tasks_path if @user.settings.update(settings_params)
  end

  private

  def settings_params
    params.permit(:agile_view)
  end

  def find_user
    @user = current_user
  end
end
