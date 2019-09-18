require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'
require 'sass'
require "sinatra/activerecord"

$LOAD_PATH.unshift(__dir__)
require 'flash.rb'
require 'models/card.rb'
require 'models/deck.rb'
require 'controllers/decks_controller.rb'

class MyApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure(:development){ 
    register Sinatra::Reloader
    also_reload "#{__dir__}/**/*.rb"
  }

  configure do
    set :method_override, true
    set :views, "#{__dir__}/views"
  end
  
  get '/' do
    slim :index
  end

  get '/screen.css' do
    sass :screen  # renders views/screen.sass as screen.css
  end
end
