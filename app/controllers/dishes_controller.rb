class DishesController < ApplicationController

  get '/dishes' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten 
    erb :'dishes/index'
  end

  get '/dishes/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @restaurants = current_user.restaurants
    @dishes = @restaurants.collect{ |r| r.dishes }.flatten
    erb :'dishes/new'
  end

  post '/dishes' do 
    redirect_if_not_logged_in
    visit = Visit.create(params[:visit])
    if !params["dish"]["name"].empty?
      visit.dish = Dish.create(params[:dish])
      visit.save
    end
    if !params["restaurant"]["name"].empty?
      dish.restaurant = Restaurant.create(params[:restaurant])
      dish.save
    end
    if visit.valid?
      redirect '/dishes'
    else
      redirect '/dishes/new?error=invalid input'
    end
  end

  get '/dishes/:id' do 
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
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    dish = Dish.find(params[:id])
    if dishes.include?(dish)
      dish.destroy
      redirect '/dishes'
    else
      redirect '/dishes?error=invalid user'
    end
    
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
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    dish = Dish.find(params[:id])
    if dishes.include?(dish)
      dish.update(params["dish"])
      if !params["restaurant"]["name"].empty?
        dish.restaurant = Restaurant.create(params[:restaurant])
        dish.save
      end
      redirect "/dishes/#{dish.id}"
    else
      redirect '/dishes?error=invalid user'
    end
  end
end