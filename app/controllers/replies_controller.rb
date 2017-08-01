class RepliesController < ApplicationController
	before_action do
    @comment = Comment.find(params[:comment_id])
  end

  def index
    @replies = @comment.replies
    @reply = @comment.replies.new
  end

  def new
    @reply = @comment.replies.new
  end

  def create

    @reply =  Reply.new(:body=>params[:reply][:body],:comment_id=>params[:reply][:comment_id])
    @reply.save
    flash[:notice]= "replies created"
    redirect_to "/blogs/#{params[:blog_id]}"
  
  end
end
