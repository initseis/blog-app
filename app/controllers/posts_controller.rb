class PostsController < ApplicationController
  before_action :update_interactions

  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    @comments = Comment.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = Comment.order(created_at: :desc)
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.text = params[:post][:text]
    @post.author_id = params[:user_id]
    if @post.save
      redirect_to user_posts_url(@post.author_id)
    else
      flash.now[:error] = 'To-do item update failed'
      render :new
    end
  end

  private

  def update_interactions
    @posts = Post.all
    @posts.each do |post|
      Comment.update_comments_counter(post)
      Like.update_likes_counter(post)
    end
  end
end
