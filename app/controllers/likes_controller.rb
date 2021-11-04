class LikesController < ApplicationController
  def like
    @like = Like.new
    @like.author_id = ApplicationController.current_user.id
    @like.post_id = params[:id]
    if @like.save
      redirect_to user_post_url(id: params[:id], user_id: params[:user_id])
    else
      flash.now[:error] = 'To-do item update failed'
      redirect_to user_posts_url(user_id: params[:user_id])
    end
  end
end
