require 'fileutils'

module CR
  def self.sync_cards
    system "git submodule update"
    load_cards_json
  end

  def self.load_cards_json
    json = JSON.parse(File.read("cr-api-data/json/cards.json"))
    json.each do |card|
      params = {
        key: card["key"],
        name: card["name"],
        elixir: card["elixir"],
        card_type: card["type"],
        rarity: card["rarity"],
        arena: card["arena"],
        description: card["description"],
        card_id: card["id"],
      }
      record = Card.find_by(card_id: card["id"])
      if record
        record.update!(params)
      else
        Card.create!(params)
      end
    end
  end

  # Get latest image from RoyaleAPI/cr-api-assets
  ASSETS_DIR = File.expand_path("~/research/cr-api-assets")
  def self.sync_images
    if File.exist?(ASSETS_DIR)
      Dir.chdir(ASSETS_DIR){ system "git pull" }
    else
      Dir.chdir(File.dirname(ASSETS_DIR)){ system "git clone https://github.com/RoyaleAPI/cr-api-assets/" }
    end
    FileUtils.cp_r("#{ASSETS_DIR}/cards-75", "public/images/")
  end
end
