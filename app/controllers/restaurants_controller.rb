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
    redirect_if_not_logged_in
    restaurant = Restaurant.create(params)
    redirect '/restaurants'
  end

  get '/restaurants/:id' do 
    redirect_if_not_logged_in
    # include more detail here: rating, review, visits, dishes, etc.
    # most recent dish
    @restaurant = Restaurant.find(params[:id])
    rec = [0,0]
    @restaurant.dishes.collect do |d|
      pairs = d.visits.collect{|v| [v.id, v.date]}
      pair = pairs.sort_by!{|d| d.second}.reverse!.first
      
      rec = pair if pair && pair[1] > rec.second 
    end
    @most_rec = Visit.find(rec[0])

    if current_user.restaurants.include?(@restaurant)
      erb :'restaurants/show'
    else
      redirect '/restaurants?error=invalid user'
    end
  end

  delete '/restaurants/:id' do
    redirect_if_not_logged_in
    restaurant = Restaurant.find(params[:id])
    if current_user.restaurants.include?(restaurant)
      restaurant.destroy
      redirect '/restaurants'
    else
      redirect '/restaurants?error=invalid user'
    end
  end

  get '/restaurants/:id/edit' do 
    redirect_if_not_logged_in
    @restaurant = Restaurant.find(params[:id])
    if current_user.restaurants.include?(@restaurant)
      erb :'restaurants/edit'
    else
      redirect '/restaurants?error=invalid user'
    end
  end
    
  patch '/restaurants/:id' do 
    redirect_if_not_logged_in
    restaurant = Restaurant.find(params[:id])
    if current_user.restaurants.include?(restaurant)
      restaurant.update(params["restaurant"])
      redirect "/restaurants/#{restaurant.id}"
    else
      redirect '/restaurants?error=invalid user'
    end
  end
end