require './idea'
class IdeaBoxApp < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    idea = Idea.new
    idea.save
    'CREATING an idea!'
  end

  not_found do
    erb :error
  end
end
