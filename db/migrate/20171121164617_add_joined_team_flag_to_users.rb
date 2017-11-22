class AddJoinedTeamFlagToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :joined_team, :boolean, default: false
    change_column :teams, :name, :string, null: false
  end
end
