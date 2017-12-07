class AddAvatarToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.has_attached_file :avatar
      t.integer :interface_color
    end
  end

  def self.down
    drop_attached_file :users, :avatar
    remove_column :users, :interface_color
  end
end
