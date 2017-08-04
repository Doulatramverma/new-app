class Api::V1::BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    @blogs = Blog.all
    render json: { status: 200, blog: @blogs, message: "success"}
    # respond_with(@blogs.to_json(:include => [:title, :description]))  
    #render :json => @blogs.to_json(:include => [:title,:description])
  end

    def create
     @blog = Blog.new(blog_params)
      if @blog.save
   
       render json: { status: 200, blog: @blog, message: "success"}
       else

       render json: { status: 401, blog: @blog.errors, message: "Failed"}
      
     end
    end  
 
   
	private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :description)
    end
   
end

