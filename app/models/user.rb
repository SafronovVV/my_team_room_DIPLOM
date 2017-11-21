class User < ApplicationRecord

  has_and_belongs_to_many :teams
  has_many :messages
  has_many :tasks
  has_many :comments

  enum team_role: { member: 0, captain: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  devise :database_authenticatable, authentication_keys: [:username]

  def email_required?
    false
  end

  def team
    teams.first
  end
end
