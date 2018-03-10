module TasksHelper
  def table_row_class(task_status)
    { "Низкий" => "success", "Обычный" => "active",
      "Высокий" => "warning", "Срочный" => "danger" }[task_status]
  end
end
