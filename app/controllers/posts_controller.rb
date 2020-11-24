class PostsController < ApplicationController 

  get "/posts" do  #index route for all posts -> READ functionality
    @posts = Post.all
    erb :'/posts/index'
  end

  get "/posts/new" do #renders a form to CREATE a new post
    redirect_if_not_logged_in
    erb :'/posts/new'
  end

  post "/posts" do  #post route, to CREATE a new post
    post = Post.new(title: params[:title], image_url: params[:image_url], content: params[:content], user_id: current_user.id)
    if post.save 
      flash[:message] = "Post successfully created!"
      redirect "/posts/#{post.id}"
    else
      flash[:error] = "Unable to create post - #{post.errors.full_messages.to_sentence}" 
      redirect "/posts/new"
    end
  end

  get "/posts/:id" do #shows single post - the id is coming from the URL - params
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  #UPDATE - link to edit on show page for post.
  #get posts/edit to render a form to edit a post
  get "/posts/:id/edit" do  
    redirect_if_not_logged_in    
    find_post
    authorized_to_edit?(@post)
    erb :'/posts/edit'
  end

  patch "/posts/:id" do #patch route to update an existing post
    find_post
    @post.update(title: params[:title], image_url: params[:image_url], content: params[:content])
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do #DELETE - delete route to delete an existing post
    find_post #we need the id to find the post to delete
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