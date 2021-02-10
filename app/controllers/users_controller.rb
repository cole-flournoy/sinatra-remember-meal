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
      redirect '/signup?error=username taken'
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
      redirect '/login?error=no match'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.clear
    redirect to '/'
  end

end