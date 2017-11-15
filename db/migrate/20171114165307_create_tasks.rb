class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0
      t.integer :priority, default: 1
      t.integer :task_type, null: false
      t.timestamps
    end
  end
end
