class RestaurantsController < ApplicationController
    
  get '/restaurants' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @my_restaurants = current_user.restaurants
    
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    redirect_if_not_logged_in
    erb :'restaurants/new'
  end

  post '/restaurants' do 
    restaurant = Restaurant.create(params)
    redirect '/restaurants'
  end

  get '/restaurants/:id' do 
    redirect_if_not_logged_in
    # include more detail here: rating, review, visits, dishes, etc.
    # most recent dish
    @restaurant = Restaurant.find(params[:id])
    if current_user.restaurants.include?(@restaurant)
      erb :'restaurants/show'
    else
      redirect '/restaurants?error=invalid user'
    end
  end

  delete '/restaurants/:id' do
    redirect_if_not_logged_in
    restaurant = Restaurant.find(params[:id])
    restaurant.destroy
    redirect '/restaurants'
  end

  get '/restaurants/:id/edit' do 
    redirect_if_not_logged_in
    @restaurant = Restaurant.find(params[:id])
    erb :'restaurants/edit'
  end
    
  patch '/restaurants/:id' do 
    redirect_if_not_logged_in
    restaurant = Restaurant.find(params[:id])
    restaurant.update(params["restaurant"])
    redirect "/restaurants/#{restaurant.id}"
  end
end