require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
@@lives = 6
@message = 'Welcome!'
@color = 'black'

get '/' do
  guess = params[:guess].to_i
  check_guess(guess)
  check_lives
  erb :index, locals: { number: settings.number,
                        message: @message,
                        color: @color,
                        lives: @@lives,
                        cheat: params[:cheat]
  }
end

def check_guess(guess)
  if guess == settings.number
    @message = "You got it right!"
    @color = 'green'
    start_new_game
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

def check_lives
  @@lives -= 1
  if @@lives == 0
    @message = "You lost! A new number has been generated. The number was #{settings.number}"
    start_new_game
  end
end

def start_new_game
  settings.number = rand(100)
  @@lives = 6
end
