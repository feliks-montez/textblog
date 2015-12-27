class CommentsController < ApplicationController
  before_action :get_parent
  
  def new
    @comment = @parent.comments.new
  end
  
  def create
    @comment = @parent.comments.new(params.require(:comment).permit(:body))
    @comment.user = current_user
     
    if @comment.save
      redirect_to @comment.post
    else
      redirect_to @parent
    end
  end
  
  private
  
  def get_parent
    @parent = Post.find(params[:post_id]) if params[:post_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]
     
    redirect_to root_path unless defined?(@parent)
  end
end
