require './idea'
class IdeaBoxApp < Sinatra::Base
  get '/' do
    erb :index, locals: { ideas: Idea.all }
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end

  not_found do
    erb :error
  end
end
