class Task < ApplicationRecord

  validates :name, :task_type, presence: true

  has_many :comments, dependent: :destroy

  enum status: { opened: 0, in_progress: 1, code_review: 2, deffered: 3, closed: 4 }
  enum priority: { low: 0, normal: 1, high: 2, urgent: 3 }
  enum task_type: { development: 0, improvement: 1, supporting: 2, fixing: 3, testing: 4 }

end
