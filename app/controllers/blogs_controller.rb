class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all

  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog=Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  def upvote
    @blog=Blog.find(params[:id])
    @blog.upvote_by current_user
   
    redirect_to :back 
  end

  def downvote
    @blog=Blog.find(params[:id])
    @blog.upvote_by current_user
   
    redirect_to :back
  end
  
 def friend

    if Friendship.where(sender: current_user.id,receiver: params[:id], accept: false).first.present?
      flash[:notice] = "you have already sent the friend  request to this user"
        
      elsif Friendship.where(sender: current_user.id,receiver: params[:id], accept: true).first.present?
       
      flash[:notice] = "You are already friend of this user"  
      else

      Friendship.create(sender: current_user.id,receiver: params[:id], accept: false )
      flash[:notice] = "freind request sent"  
    end
  
    redirect_to blog_profile_path(id: current_user.id)
  end

  def accept_friend

   @abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
   @abc.update(accept: true)
    flash[:notice] = "Now you are friend with #{User.where(id: params[:se]).first.email}"
    redirect_to blog_profile_path(id: current_user.id)
  end
 def delete_friend

   @abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
   @abc.destroy
   flash[:notice] = "request deleted"
   redirect_to blog_profile_path(id: current_user.id)
  end
  # def notification

  #  @likenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "like")
  #   @dislikenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "dislike")
    
  # end

  # GET /users/:id.:format
  def profile
    
   if Friendship.where(receiver: current_user.id).first.present?
      @friend_request=Friendship.where(receiver: current_user.id)
    end 

    @user = User.all.where.not(id: current_user)
    
  
    if Friendship.where(receiver: current_user.id).first.present? || Friendship.where(sender: current_user.id).first.present?

      @friends = Friendship.where(receiver: current_user.id)
    
      @friends1 = Friendship.where(sender: current_user.id)
    end
  end










  # POST /blogs
  # POST /blogs.json

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
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
