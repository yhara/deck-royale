class AddNoteToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :note, :text, null: false, default: ""
  end
end
