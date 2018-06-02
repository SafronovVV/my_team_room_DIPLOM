module TasksHelper
  def priority_class(task_priority)
    { "Низкий" => "success", "Обычный" => "active",
      "Высокий" => "warning", "Срочный" => "danger" }[task_priority]
  end
end
