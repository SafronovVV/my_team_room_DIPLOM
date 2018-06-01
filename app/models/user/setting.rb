class User::Setting < ApplicationRecord
  belongs_to :user, class_name: User.name
end
