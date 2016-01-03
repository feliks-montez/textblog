class CommentsController < ApplicationController
  before_action :get_parent
  
  def new
    @comment = @parent.comments.new
  end
  
  def create
    @comment = @parent.comments.new(params.require(:comment).permit(:body))
    @comment.user = current_user
     
    if @comment.save
      message_body = "["+@comment.user.name+"]("+user_path(@comment.user)+") commented on your [post]("+post_path(@comment.post)+"#comment-"+@comment.id.to_s+")" if @comment.commentable.is_a? Post
      message_body = "["+@comment.user.name+"]("+user_path(@comment.user)+") replied to your [comment]("+post_path(@comment.post)+"#comment-"+@comment.id.to_s+")" if @comment.commentable.is_a? Comment
      Message.create(recipient_id: @parent.user_id, body: message_body)
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
