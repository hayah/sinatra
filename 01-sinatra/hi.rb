require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)

get '/' do
  erb :index, locals: { number: secret_number }
end
