class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.integer :team_role, default: 0
      t.timestamps null: false
    end

    create_table :teams do |t|
      t.string :name
      t.references :captain, index: true, foreign_key: { to_table: :users }
    end

    create_table :teams_users do |t|
      t.belongs_to :team
      t.belongs_to :user
    end

    add_index :users, [:email, :username], unique: true
    add_index :teams_users, [:user_id, :team_id]
    add_reference :messages, :user, index: true
    add_reference :tasks, :user, index: true
    add_reference :tasks, :team, index: true
    add_reference :comments, :user, index: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
