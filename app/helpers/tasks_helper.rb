module TasksHelper
  def table_row_class(task_status)
    { "low" => "success", "normal" => "active",
      "high" => "warning", "urgent" => "danger" }[task_status]
  end
end
