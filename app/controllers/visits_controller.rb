class VisitsController < ApplicationController

  delete '/visits/:id' do
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    visit = Visit.find(params[:id])
    if dishes.include?(visit.dish)
      visit.destroy
      redirect '/dishes'
    else
      redirect '/dishes?error=invalid user'
    end
  end

  get '/visits/:id/edit' do 
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    @visit = Visit.find(params[:id])
    if dishes.include?(@visit.dish)
      erb :'visits/edit'
    else
      redirect '/dishes?error=invalid user'
    end
  end

  patch '/visits/:id' do 
    redirect_if_not_logged_in
    dishes = current_user.restaurants.collect{ |r| r.dishes }.flatten
    visit = Visit.find(params[:id])
    if dishes.include?(visit.dish)
      visit.update(params["visit"])
      redirect '/dishes'
    else
      redirect '/dishes?error=invalid user'
    end
  end

end
