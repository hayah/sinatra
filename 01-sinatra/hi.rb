require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)

get '/hi' do
  "The SECRET NUMBER is: #{secret_number}"
end
