class UsersController < ApplicationController
  def index
    @users = User.all
    @users.each do |user|
      Post.update_post_counter(user)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = User.most_recent_posts(@user)
    @posts.each do |post|
      Comment.update_comments_counter(post)
      Like.update_likes_counter(post)
    end
  end
end
