class DishesController < ApplicationController

  get '/dishes' do
    # only the user's dishes
    @dishes = Dish.all
    erb :'dishes/index'
  end

  get '/dishes/new' do
    @restaurants = Restaurant.all
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
    @dish = Dish.find(params[:id])
    erb :'dishes/show'
  end

  delete '/dishes/:id' do
    dish = Dish.find(params[:id])
    dish.destroy
    redirect '/dishes'
  end

  get '/dishes/:id/edit' do 
    @dish = Dish.find(params[:id])
    @restaurants = Restaurant.all
    erb :'dishes/edit'
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