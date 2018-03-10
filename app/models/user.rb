class User < ApplicationRecord

  has_and_belongs_to_many :teams
  has_many :messages
  has_many :tasks
  has_many :comments
  has_many :appointed_tasks, class_name: 'Task'

  has_attached_file :avatar, styles: { profile: '200x200#' }, default_url: "default_user_logo.png"
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  enum team_role: { member: 0, captain: 1 }

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  devise :database_authenticatable, authentication_keys: [:username]

  validates :username, :email, presence: true, uniqueness: true
  validates :username, length: { in: 3..20 }

  def team
    teams.first
  end
end
