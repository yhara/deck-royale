class Card < ActiveRecord::Base
  has_and_belongs_to_many :decks, join_table: :decks_cards
  validates :key, presence: true
  validates :name, presence: true
  validates :elixir, presence: true
  validates :card_type, presence: true
  validates :rarity, presence: true
  validates :arena, presence: true
  validates :description, presence: true
  validates :card_id, presence: true
end
