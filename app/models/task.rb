class Task < ApplicationRecord

  validates :name, :task_type, presence: true

  enum status: { opened: 0, in_progress: 1, deffered: 2, closed: 3 }
  enum priority: { low: 0, normal: 1, high: 2, urgent: 3 }
  enum task_type: { development: 0, improvement: 1, supporting: 2, fixing: 3, testing: 4 }

end
