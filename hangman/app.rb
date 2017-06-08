require './models/hangman'
set :slim, pretty: true
set :session_secret, "something"

enable :sessions

get '/' do
  slim :index
end

get '/new' do
  session[:hangman] = Hangman.new
  redirect '/game'
end

get '/game' do
  slim :game, locals: {
    hangman: session[:hangman],
    alphabet: ('a'..'z').to_a
  }
end

get '/game/:letter' do |letter|
  session[:hangman].next_turn(letter)
  redirect '/game'
end
