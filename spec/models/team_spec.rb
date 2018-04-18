require 'rails_helper'

RSpec.describe Team, type: :model do
  before do
    User.create!(username: 'user', email: 'email@mail.ru', password: 'password', team_role: 'Капитан')
  end
  subject { Team.new(name: 'Team1', captain_id: User.first.id) }
  it { expect(subject).to validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
end
