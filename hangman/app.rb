set :slim, pretty: true

get '/' do
  slim :index
end

get '/game' do
  slim :game
end
