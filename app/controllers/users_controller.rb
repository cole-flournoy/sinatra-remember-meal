class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  post '/signup' do
    user = User.new(username: params[:username], password: params[:password])

    if user.save
      user.save
      session[:user_id] = user.id
      redirect '/restaurants'
    else
      redirect '/signup'
    end

  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/restaurants'
    else
      "No Match Found"
      # redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '../'
  end

end