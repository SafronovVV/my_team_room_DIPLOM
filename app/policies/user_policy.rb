class UserPolicy
  attr_reader :user
  def initialize(user)
    @user = user
  end

  def chose_role?
    user && user.chose_role
  end

  def joined_team?
    user && user.joined_team? && !user.team.nil?
  end

  def fully_registered?
    user && user.chose_role? && user.joined_team?
  end

  def expect_invitation?
    user && !user.joined_team? && !user.team.nil?
  end

  def not_joined_team?
    user && !user.joined_team? && user.team.nil?
  end

  def able_to_edit_team?
    user && user.team_role == 'Капитан' && user.team.captain == user
  end
end
