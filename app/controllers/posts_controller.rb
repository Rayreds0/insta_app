class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def home
    @posts = Post.all.order('created_at desc')
    @users = User.where.not(id: current_user.id).sample(3)
    @following = current_user.following.sample(3)
    @comment = Comment.new
  end

  def index
    @posts = Post.all
    @users = User.where.not(id: current_user.id).sample(4)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to home_path
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Task was successfully updated.'
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit!
  end

end
