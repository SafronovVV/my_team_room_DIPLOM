class WikiDocument < ApplicationRecord
  belongs_to :team
  validates :title, :body, presence: true
end
