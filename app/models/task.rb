class Task < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :team
  belongs_to :user
  belongs_to :appointed_to, class_name: 'User'
  has_many :subtasks, class_name: 'Task', foreign_key: :parent_task_id
  belongs_to :parent_task, class_name: 'Task', optional: true


  enum status: { "Открыта" => 0, "В процессе" => 1, "Проверяется" => 2, "Исправляется" => 3, "Отложена"=> 4, "Закрыта" => 5 }
  enum priority: { "Низкий" => 0, "Обычный" => 1, "Высокий" => 2, "Срочный" => 3 }
  enum task_type: { "Разработка" => 0, "Улучшение" => 1, "Поддержка" => 2, "Исправление" => 3, "Тестирование" => 4 }

  validates :name, :status, :priority, :task_type, :appointed_to_id, presence: true
  validates :name, length: { in: 5..30 }
  validates_numericality_of :percentage, less_than_or_equal_to: 100, greater_than_or_equal_to: 0
  validates :percentage, presence: true

end
