require 'spec_helper'

describe Deck do
  it '.create_from_url' do
    deck = Deck.create_from_url("clashroyale://copyDeck?deck=26000015;28000015;26000027;26000009;26000035;26000039;28000012;26000063;", "Deck1")
    expect(deck.title).to eq("Deck1")
    names = deck.cards.pluck(:key).sort
    expect(names).to eq(%w(
      baby-dragon
      barbarian-barrel
      dark-prince
      electro-dragon
      golem
      lumberjack
      mega-minion
      tornado
    ))
  end
end
