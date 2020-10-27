class PostsController < ApplicationController 

  get "/posts" do
    @posts = Post.all
    erb :'/posts/index'
  end

  get "/posts/new" do
    if logged_in?
      erb :'/posts/new'
    else
      "error message - you must be logged in to view this content"
      redirect "/"
    end
  end

  post "/posts" do
    post = Post.new(title: params[:title], image_url: params[:image_url], content: params[:content], user_id: current_user.id)
    if post.save 
      redirect "/posts/#{post.id}"
    else
      "flash error" 
      redirect "/posts/new"
    end
  end

  get "/posts/:id" do
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  get "/posts/:id/edit" do
    @posts = Post.find(params[:id])
    if authorized_to_edit?(@post)
      erb :'/posts/edit'
    else
      "flash error"
      redirect "/posts"
    end
  end

  patch "/posts/:id" do
    @post = Post.find(params[:id])
    @post.update(title: params[:title], image_url: params[:image_url], content: params[:content])
    redirect "/posts/#{@post.id}"
  end

end