class Api::V1::CommentsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  respond_to :json

	def create
    @blog = Blog.find(params[:blog_id])
    @comment =  @blog.comments.create(comment_params)
    if @comment.save
      render status: 200, json: {result: :success, message: "Blog comment created successfully", comment: @blog.comments}
    else
      render status: 400, json: {errors: "Failed to create comment"}, ststus: :unprocessable_entity
    end
  end

   

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
