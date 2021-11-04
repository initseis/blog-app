class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author_id = ApplicationController.current_user.id
    @like.post_id = params[:id]
    @post = Post.find(params[:id])
    if @like.save
      Like.update_likes_counter(@post)
      flash[:notice] = 'Liked'
      redirect_to user_post_url(id: params[:id], user_id: params[:user_id])
    else
      flash[:error] = 'Like Failed'
      redirect_to user_posts_url(user_id: params[:user_id])
    end
  end
end
