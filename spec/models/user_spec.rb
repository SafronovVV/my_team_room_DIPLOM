require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    User.create!(username: 'user', email: 'email@mail.ru', password: 'password', team_role: 'Капитан')
  end
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:email) }
end
