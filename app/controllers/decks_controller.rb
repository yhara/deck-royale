class MyApp < Sinatra::Base
  get '/decks' do
    session["ct"] ||= 0; session["ct"] += 1
    @decks = Deck.order(updated_at: :desc).include(:card)
    slim :'decks/index'
  end

  get '/decks/new' do
    @deck = Deck.new
    slim :'decks/new'
  end

  get '/decks/:id' do
    @deck = Deck.find_by!(id: params[:id])
    slim :'decks/show'
  end

  post '/decks' do
    @deck = Deck.create_from_url(params[:deck_url], params[:title])
    if @deck.save
      @flash[:notice] = "Created record: #{@deck.title}"
      redirect "/" # "/decks/#{@deck.id}"
    else
      @flash[:alert] = "Failed to save record: #{@deck.errors.messages.inspect}"
      redirect "/" #slim :'decks/new'
    end
  end

  get '/decks/:id/edit' do
    @deck = Deck.find_by!(id: params[:id])
    slim :'decks/edit'
  end

  put '/decks/:id' do
    @deck = Deck.find_by!(id: params[:id])
    @deck.title = params[:title]
    @deck.note = params[:note]
    if @deck.save
      @flash[:notice] = "Updated record: #{@deck.title}"
      redirect "/decks/#{@deck.id}"
    else
      slim :'decks/edit'
    end
  end

  delete '/decks/:id' do
    deck = Deck.find_by!(id: params[:id])
    deck.destroy
    @flash[:notice] = "Deleted record: #{deck.title}"
    redirect "/decks"
  end
end
