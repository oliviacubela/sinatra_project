class UsersController < ApplicationController
   
  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    user = User.find_by(email: params[:email])
    # binding.pry
    if user && user.authenticate(params[:password])
      
      session[:user_id] = user.id  
      flash[:message] = "Welcome back, #{user.username}!"
      redirect "/users/#{user.id}"

    else 
      flash[:error] = "Your login credentials are invalid. Please try again."
      redirect '/login'
    end
  end

  get "/users/:id" do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post "/users" do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.username}!" 

      redirect "/users/#{@user.id}"

    else
      flash[:error] = "Unable to create account - #{@user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear 
    redirect :'/'
  end
end