class DishesController < ApplicationController

  get '/dishes' do
    @error_message = params[:error]
    redirect_if_not_logged_in
    @dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    
    erb :'dishes/index'
  end

  get '/dishes/new' do
    redirect_if_not_logged_in
    @restaurants = current_user.restaurants
    erb :'dishes/new'
  end

  post '/dishes' do 
    @dish = Dish.create(params[:dish])
    if !params["restaurant"]["name"].empty?
      @dish.restaurant = Restaurant.create(params[:restaurant])
      @dish.save
    end
    redirect '/dishes'
  end

  get '/dishes/:id' do 
    # add details here
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    @dish = Dish.find(params[:id])
    if dishes.include?(@dish)
      erb :'dishes/show'
    else
      redirect '/dishes?error=invalid user'
    end
  end

  delete '/dishes/:id' do
    dish = Dish.find(params[:id])
    dish.destroy
    redirect '/dishes'
  end

  get '/dishes/:id/edit' do 
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    @dish = Dish.find(params[:id])
    @restaurants = current_user.restaurants
    if dishes.include?(@dish)
      erb :'dishes/edit'
    else
      redirect '/dishes?error=invalid user'
    end
  end

  patch '/dishes/:id' do 
    dish = Dish.find(params[:id])
    dish.update(params["dish"])
    if !params["restaurant"]["name"].empty?
      dish.restaurant = Restaurant.create(params[:restaurant])
      dish.save
    end
      redirect "/dishes/#{dish.id}"
  end
end