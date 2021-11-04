class UsersController < ApplicationController
  before_action :update_interactions

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = User.most_recent_posts(@user)
  end

  private

  def update_interactions
    @users = User.all
    @users.each do |user|
      Post.update_post_counter(user)
    end
  end
end
