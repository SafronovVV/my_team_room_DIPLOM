class Team < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :captain, class_name: 'User'
  has_many :tasks
  has_one :chat

  validates :name, presence: true, uniqueness: true, length: { in: 3..30 }

  def active_users
    users.where(joined_team: true)
  end

end
