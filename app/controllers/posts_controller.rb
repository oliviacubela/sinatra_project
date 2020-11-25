class PostsController < ApplicationController 

  get "/posts" do  
    @posts = Post.all
    erb :'/posts/index'
  end

  get "/posts/new" do 
    redirect_if_not_logged_in
    erb :'/posts/new'
  end

  post "/posts" do  
    post = Post.new(title: params[:title], image_url: params[:image_url], content: params[:content], user_id: current_user.id)
    if post.save 
      flash[:message] = "Post successfully created!"
      redirect "/posts/#{post.id}"
    else
      flash[:error] = "Unable to create post - #{post.errors.full_messages.to_sentence}" 
      redirect "/posts/new"
    end
  end

  get "/posts/:id" do 
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  get "/posts/:id/edit" do  
    redirect_if_not_logged_in    
    find_post
    if authorized_to_edit?(@post)
      erb :'/posts/edit'
    else 
      flash[:error] = "Not authorized to edit that post."
      redirect "/posts/#{@post.id}"
    end
  end

  patch "/posts/:id" do 
    find_post
    @post.update(title: params[:title], image_url: params[:image_url], content: params[:content])
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do 
    find_post 
    authorized_to_edit?(@post)
    @post.destroy
    flash[:message] = "Successfully deleted post!"
    redirect '/posts'
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

end