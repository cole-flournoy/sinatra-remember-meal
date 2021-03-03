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
      new_dish = Dish.new(params[:dish])
      if !params["restaurant"]["name"].empty?
        new_rest = Restaurant.create(params[:restaurant])
        new_dish.restaurant = new_rest
      end
      new_dish.save
      visit.dish = new_dish
    else
      if !params["restaurant"]["name"].empty?
        new_rest = Restaurant.create(params[:restaurant])
        visit.dish.restaurant = new_rest
      end
    end
  
    binding.pry
    if visit.valid?
      visit.save
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