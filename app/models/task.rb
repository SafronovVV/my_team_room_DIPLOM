class Task < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :team
  belongs_to :user
  belongs_to :appointed_to, class_name: 'User'
  has_many :subtasks, class_name: 'Task', foreign_key: :parent_task_id
  belongs_to :parent_task, class_name: 'Task', optional: true


  enum status: { opened: 0, in_progress: 1, code_review: 2, repair: 3, deffered: 4, closed: 5 }
  enum priority: { low: 0, normal: 1, high: 2, urgent: 3 }
  enum task_type: { development: 0, improvement: 1, supporting: 2, fixing: 3, testing: 4 }

  validates :name, :status, :priority, :task_type, :appointed_to_id, presence: true
  validates :name, length: { in: 5..30 }
  validates_numericality_of :percentage, less_than_or_equal_to: 100, greater_than_or_equal_to: 0
  validates :percentage, presence: true

end
