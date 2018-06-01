class CreateUserSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_settings do |t|
      t.boolean :agile_view, default: false
      t.references :user, index: true
      t.timestamps
    end
  end
end
