class CreateWikiDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :wiki_documents do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :team, index: true
      t.timestamps
    end
  end
end
