require './models/hangman'
set :slim, pretty: true
set :session_secret, "something"

enable :sessions

get '/' do
  cookies[:played] ||= 0
  cookies[:wins] ||= 0
  slim :index, locals: { hangman: session[:hangman] }
end

get '/new' do
  cookies[:played] = cookies[:played].to_i + 1
  session[:hangman] = Hangman.new
  redirect '/game'
end

get '/game' do
  session[:hangman] ||= Hangman.new
  slim :game, locals: {
    hangman: session[:hangman],
    alphabet: ('a'..'z').to_a
  }
end

get '/game/:letter' do |letter|
  session[:hangman].next_turn(letter)
  check_game_state(session[:hangman])
  redirect '/game'
end

get '/win' do
  slim :win
end

get '/lose' do
  slim :lose, locals: { hangman: session[:hangman] }
end

get '/save' do
  session[:hangman].save_game
  redirect '/'
end

get '/load' do
  session[:hangman].load_game
  redirect '/game'
end

def check_game_state(game)
  if game.state == 'win'
    redirect '/win'
  elsif game.state == 'lose'
    redirect '/lose'
  end
end
