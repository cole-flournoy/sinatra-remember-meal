class RestaurantsController < ApplicationController
    
    configure do
        set :views, 'app/views/restaurants'
    end
    
    get '/restaurants' do
        # make this only the user's restaurants
        # main index at '/' should be all users' restaurants
        @restaurants = Restaurant.all
        erb :index
    end

    post '/restaurants' do 
        Restaurant.create(params)
        redirect '/restaurants'
    end

    get '/restaurants/new' do
        erb :new
    end

    get '/restaurants/:id' do 
        # include more detail here: rating, review, visits, dishes, etc.
        @restaurant = Restaurant.find(params[:id])
        erb :show
    end

    delete '/restaurants/:id' do
        restaurant = Restaurant.find(params[:id])
        restaurant.destroy
        redirect '/restaurants'
    end

    get '/restaurants/:id/edit' do 
        @restaurant = Restaurant.find(params[:id])
        erb :edit
    end
    
    post '/restaurants/:id' do 
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(params)
        redirect "/restaurants/#{@restaurant.id}"
    end
end