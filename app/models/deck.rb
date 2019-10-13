class Deck < ActiveRecord::Base
  has_and_belongs_to_many :cards, join_table: :decks_cards
  validates :title, presence: true

  class InvalidDeckUrl < StandardError; end
  DECK_URL_REXP = %r(\?deck=(.*))
  def self.create_from_url(url, title)
    raise InvalidDeckUrl unless DECK_URL_REXP =~ url
    deck = Deck.new(title: title)
    Deck.transaction do
      $1.split(";").each do |card_id_str|
        card = Card.find_by!(card_id: card_id_str.to_i)
        deck.cards << card
      end
      raise InvalidDeckUrl unless deck.cards.length == 8
      deck.save!
    end
    deck
  end

  def deck_url
    "clashroyale://copyDeck?deck=" + cards.pluck(:card_id).join(';')
  end
end
