require 'sinatra/base'
require_relative '../data_mapper_setup'
# require_relative './models/link.rb'


class BookmarkManager < Sinatra::Base
  get '/' do
    erb :'links/home'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                    title: params[:title])
    tag = Tag.create(name: params[:tag])
    link.tags << tag
    link.save
    # Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end


  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
