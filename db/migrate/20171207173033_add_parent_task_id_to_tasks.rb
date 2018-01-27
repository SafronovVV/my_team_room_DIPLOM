class AddParentTaskIdToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :parent_task, index: true, foreign_key: true
  end
end
