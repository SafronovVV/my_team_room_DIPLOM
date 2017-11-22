class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.references :team, index: true
      t.timestamps
    end

    add_reference :messages, :chat, index: true
  end
end
