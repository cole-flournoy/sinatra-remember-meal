class UsersController < ApplicationController

  configure do
    set :views, 'app/views/users'
  end

  get '/signup' do
    erb :new
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
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      "Congratulations #{user.username}"
    else
      "No Match Found"
      # redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end