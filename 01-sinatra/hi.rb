require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
message = ''

get '/' do
  guess = params[:guess].to_i
  message = check_guess(guess)
  erb :index, locals: { number: settings.number, message: message }
end

def check_guess(guess)
  if guess == 0
    "Welcome!"
  elsif guess == settings.number
    "You got it right!"
  elsif guess > settings.number + 5
    "Way too high!"
  elsif guess < settings.number - 5
    "Way too low!"
  elsif guess > settings.number
    "Too high!"
  else
    "Too low!"
  end
end
