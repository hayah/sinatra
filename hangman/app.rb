require './models/hangman'
set :slim, pretty: true
set :session_secret, "something"

enable :sessions

get '/' do
  slim :index
end

get '/new' do
  session[:hangman] = Hangman.new
  h = session[:hangman]
  session[:secret]      = h.secret_word
  session[:lives]       = 8
  session[:incorrect]   = []
  session[:placeholder] = h.placeholder
  session[:available]   = ('a'..'z').to_a
  redirect '/game'
end

get '/game' do
  slim :game, locals: {
    hangman: session[:hangman],
    secret: session[:secret],
    lives: session[:lives],
    incorrect: session[:incorrect],
    placeholder: session[:placeholder],
    available: session[:available],
    alphabet: ('a'..'z').to_a
  }
end

get '/game/:letter' do |letter|
  session[:hangman].next_turn(letter)
  if session[:secret].include?(letter)
    session[:placeholder] = new_placeholder(letter)
  else
    session[:incorrect] << letter
  end
  session[:available].delete(letter)
  redirect '/game'
end

def new_placeholder(letter)
  session[:placeholder].chars.each_with_index.map do |underscore, i|
    if session[:secret][i] == letter
      session[:secret][i]
    else
      underscore
    end
  end.join('')
end

