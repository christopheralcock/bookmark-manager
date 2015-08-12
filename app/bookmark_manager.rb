require 'sinatra/base'
require 'sinatra/flash'
require_relative '../data_mapper_setup'
# require_relative './models/link.rb'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end
  end

  get '/' do
    erb :'links/home'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags] == "" ? params[:tags] = "untagged" : params[:tags] = params[:tags]
    tags_array = (params[:tags]).split(" ")
    tags_array.each do |word|
      tag = Tag.create(name: word)
      link.tags << tag
      link.save
    end
    # tag = Tag.create(name: params[:tag])
    # link.tags << tag
    # link.save
    # Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    # we just initialize the object
    # without saving it. It may be invalid
    user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if user.save # #save returns true/false depending on whether the model is successfully saved to the database.
      session[:user_id] = user.id
      redirect to('/links')
      # if it's not valid,
      # we'll render the sign up form again
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end





  # start the server if ruby file executed directly
  run! if app_file == $0
end
