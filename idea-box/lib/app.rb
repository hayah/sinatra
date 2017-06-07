require 'idea_box'
class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    erb :index, locals: { ideas: IdeaStore.all.sort, idea: Idea.new(params) }
  end

  post '/' do
    params[:idea][:tags] = params[:idea][:tags].split(',')
    params[:idea][:tags] = params[:idea][:tags].map(&:strip)

    IdeaStore.create(params[:idea])
    redirect '/'
  end

  get '/:id' do |id|
    idea =  IdeaStore.find(id.to_i)
    erb :show, locals: { idea: idea, id: id }
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    params[:idea][:tags] = params[:idea][:tags].split(',')
    params[:idea][:tags] = params[:idea][:tags].map(&:strip)
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  get '/tags' do
    tags = IdeaStore.all_tags
    tags = tags.split(/\W/).select { |tag| tag =~ /\w/ }
    erb :index_tag, locals: { tags: tags }
  end

  get '/tags/:t' do |t|
    ideas = IdeaStore.find_by_tag(t)
    erb :show_tag, locals: { ideas: ideas, tag: t }
  end

  not_found do
    erb :error
  end
end
