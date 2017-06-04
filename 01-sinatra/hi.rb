require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)
message = ''

get '/' do
  guess = params[:guess].to_i
  message = check_guess(guess, secret_number)
  erb :index, locals: { number: secret_number, message: message }
end

def check_guess(guess, secret_number)
  if guess == 0
    "Welcome!"
  elsif guess == secret_number
    "You got it right!"
  elsif guess > secret_number + 5
    "Way too high!"
  elsif guess < secret_number - 5
    "Way too low!"
  elsif guess > secret_number
    "Too high!"
  else
    "Too low!"
  end
end
