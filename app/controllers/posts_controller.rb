class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :share, :delete]
  before_action :set_current_user, only: [:index, :destroy, :delete]

  # GET /posts
  # GET /posts.json
  def index
    current_user = User.find_by_id(session[:current_user_id])
    friends = Array.new
    @relationsip = Relationship.where('user1_id = ? AND status = ?', session[:current_user_id], "Accept")
    @relationsip.each do |relationsip|
      friends.push(relationsip.user2_id)
    end
    if current_user != nil && current_user.role == 0
      @posts = Post.all
    else
      @posts = Post.where('user_id IN (?) OR user_id = ?', friends, session[:current_user_id]).order("created_at DESC")
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.user_id = session[:current_user_id]

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @current_user.role == 0 || @post.user.id == @current_user.id
      @post.destroy
    end
    if @post.destroyed?
      redirect_to posts_path, notice: 'Post was successfully destroyed.'
    else
      edirect_to posts_path, notice: 'Post was not successfully destroyed.'
    end
  end

  def share
    text = "@" + @post.user.nick + ": " + @post.text

    @post_shared = Post.create(user_id: session[:current_user_id], text: text)
    if @post_shared.save
      redirect_to posts_path
    else
      redirect_to posts_path, notice: 'Post was not successfully shared.'
    end
  end

  def delete
    if @current_user.role == 0 || @post.user.id == @current_user.id
      if Post.destroy(@post.id)
        redirect_to posts_path
      else
        redirect_to posts_path, notice: 'Post was not successfully destroyed.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_current_user
      @current_user = User.find_by_id(session[:current_user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :text, :image)
    end
end
