class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:id]
    if @comment.save
      flash[:notice] = 'Comment added'
      respond_to do |format|
        format.html { redirect_to user_post_url(id: params[:id], user_id: params[:user_id]) }
        format.json { render json: @comment }
      end
    else
      flash[:notice] = 'Comment not added'
      render :new
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:comment_id])
    if @comment.destroy
      Like.update_likes_counter(@post)
      Comment.update_comments_counter(@post)
      flash[:notice] = 'Comment deleted succesfully'
    else
      flash[:error] = 'Comment not deleted'
    end
    redirect_back(fallback_location: root_path)
  end
  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
