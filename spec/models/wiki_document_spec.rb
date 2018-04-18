require 'rails_helper'

RSpec.describe WikiDocument, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
