require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:priority) }
  it { should validate_presence_of(:task_type) }
  it { should validate_presence_of(:appointed_to_id) }
  it { should validate_presence_of(:percentage) }
  it { should validate_length_of(:name).is_at_least(5).is_at_most(30) }
end
