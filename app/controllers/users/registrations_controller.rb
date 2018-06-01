class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    edit_users_team_role_path(resource)
  end
end
