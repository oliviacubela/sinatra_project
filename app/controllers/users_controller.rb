class UsersController < ApplicationController
   
  get "/login" do
    erb :'login'
  end

  post "/login" do
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      
      session[:user_id] = user.id

    else
      redirect '/login'
    end
  end
end