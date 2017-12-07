class AddColumnAppointedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :appointed_to, index: true, foreign_key: { to_table: :users }
  end
end
