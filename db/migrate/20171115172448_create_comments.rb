class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.timestamps
    end
    add_reference :comments, :task, index: true
  end
end
