class UsersController < ApplicationController

    configure do
        set :views, 'app/views/users'
    end

    get '/signup' do
        erb :new
    end

    post '/signup' do
    
    end

    get '/login' do
        erb :login
    end

    post '/login' do
        
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end