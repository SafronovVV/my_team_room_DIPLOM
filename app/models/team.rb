class Team < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :captain, class_name: 'User'
  has_many :tasks
end
