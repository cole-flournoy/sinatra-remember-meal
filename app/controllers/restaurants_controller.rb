class RestaurantsController < ApplicationController
    
  get '/restaurants' do
    redirect_if_not_logged_in
    user = User.find_by(id: session[:user_id])
    @my_restaurants = user.restaurants
    
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    erb :'restaurants/new'
  end

  post '/restaurants' do 
    restaurant = Restaurant.create(params)
    restaurant.user = current_user 
    restaurant.save

    redirect '/restaurants'
  end

  get '/restaurants/:id' do 
    # include more detail here: rating, review, visits, dishes, etc.
    # most recent dish
    @restaurant = Restaurant.find(params[:id])
    erb :'restaurants/show'
  end

  delete '/restaurants/:id' do
    restaurant = Restaurant.find(params[:id])
    restaurant.destroy
    redirect '/restaurants'
  end

  get '/restaurants/:id/edit' do 
    @restaurant = Restaurant.find(params[:id])
    erb :'restaurants/edit'
  end
    
  patch '/restaurants/:id' do 
    restaurant = Restaurant.find(params[:id])
    restaurant.update(params["restaurant"])
    redirect "/restaurants/#{restaurant.id}"
  end
end