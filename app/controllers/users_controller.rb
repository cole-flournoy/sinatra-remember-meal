class UsersController < ApplicationController

  get '/signup' do
    @error_message = params[:error]
    if !logged_in?
      erb :'users/new'
    else
      redirect '/restaurants'
    end
  end

  post '/signup' do
    existing_username = User.find_by(username: params[:username])
    if existing_username
      redirect '/signup?error=That username already exists'
    else
      new_user = User.new(username: params[:username], password: params[:password])

      if new_user.save
        new_user.save
        session[:user_id] = new_user.id
        redirect '/restaurants'
      else
        redirect '/signup'
      end
    end
  end

  get '/login' do
    @error_message = params[:error]
    if !logged_in?
      erb :'users/login'
    else
      redirect '/restaurants'
    end
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