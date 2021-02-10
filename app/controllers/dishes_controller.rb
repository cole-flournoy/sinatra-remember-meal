class DishesController < ApplicationController

  get '/dishes' do
    redirect_if_not_logged_in
    # only the user's dishes
    @dishes = Dish.all
    erb :'dishes/index'
  end

  get '/dishes/new' do
    redirect_if_not_logged_in
    @restaurants = Restaurant.all
    erb :'dishes/new'
  end

  post '/dishes' do 
    redirect_if_not_logged_in
    @dish = Dish.create(params[:dish])
    if !params["restaurant"]["name"].empty?
      @dish.restaurant = Restaurant.create(params[:restaurant])
      @dish.save
    end
    redirect '/dishes'
  end

  get '/dishes/:id' do 
    redirect_if_not_logged_in
    @dish = Dish.find(params[:id])
    erb :'dishes/show'
  end

  delete '/dishes/:id' do
    redirect_if_not_logged_in
    dish = Dish.find(params[:id])
    dish.destroy
    redirect '/dishes'
  end

  get '/dishes/:id/edit' do 
    redirect_if_not_logged_in
    @dish = Dish.find(params[:id])
    @restaurants = Restaurant.all
    erb :'dishes/edit'
  end

  patch '/dishes/:id' do 
    redirect_if_not_logged_in
    dish = Dish.find(params[:id])
    dish.update(params["dish"])
    if !params["restaurant"]["name"].empty?
      dish.restaurant = Restaurant.create(params[:restaurant])
      dish.save
    end
      redirect "/dishes/#{dish.id}"
  end
end