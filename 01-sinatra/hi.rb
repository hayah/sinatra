require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
@message = 'Welcome!'
@color = 'black'

get '/' do
  guess = params[:guess].to_i
  check_guess(guess)
  erb :index, locals: { number: settings.number, message: @message, color: @color }
end

def check_guess(guess)
  if guess == settings.number
    @message = "You got it right!"
    @color = 'green'
  elsif guess > settings.number + 5
    @message = "Way too high!"
    @color = '#bc0918'
  elsif guess < settings.number - 5
    @message = "Way too low!"
    @color = '#bc0918'
  elsif guess > settings.number
    @message = "Too high!"
    @color = '#f79c1d'
  else
    @message = "Too low!"
    @color = '#f79c1d'
  end
end
