require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "whatdidigetlasttime"
  end

  get "/" do
    @restaurants = Restaurant.all
    @dishes = Dish.all
    erb :index
  end

  post '/results' do
    @results = Dish.where("name LIKE ?", "%#{params[:search]}%")

    erb :results
  end 
  
  
  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login?error=not logged in'
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end
end