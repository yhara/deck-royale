class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :title, null: false
      t.timestamps
    end

    create_table :decks_cards do |t|
      t.references :deck
      t.references :card
    end

    create_table :cards do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.integer :elixir, null: false
      t.string :card_type, null: false
      t.string :rarity, null: false
      t.string :arena, null: false
      t.text :description, null: false
      t.integer :card_id, null: false
    end
    add_index :cards, :key
    add_index :cards, :card_id
  end
end
