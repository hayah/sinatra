require './models/hangman'
set :slim, pretty: true
set :session_secret, "something"

enable :sessions

get '/' do
  slim :index
end

post '/new' do
  h = Hangman.new
  session[:secret]      = h.secret_word
  session[:lives]       = 10
  session[:incorrect]   = h.incorrect_letters
  session[:placeholder] = h.placeholder
  session[:available]   = h.available_letters
  redirect '/game'
end

get '/game' do
  slim :game, locals: {
    secret: session[:secret],
    lives: session[:lives],
    incorrect: session[:incorrect],
    placeholder: session[:placeholder],
    available: session[:available]
  }
end
