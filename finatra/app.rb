require 'sinatra'
require 'sinatra/reloader'
require_relative 'db/models'

get '/' do
  @fishes = Fish.all
  erb :index, layout: :main
end

get '/:fish_name' do
  @fish = params[:fish_name]
  erb :show, layout: :main
end

post '/' do
  name = params[:name]
  description = params[:description]
  Fish.create!({ name: name, description: description })
  redirect '/'
end
