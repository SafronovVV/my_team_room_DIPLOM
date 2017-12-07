class AddPercentageToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :percentage, :integer, default: 0
  end
end
