class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :delete]

  # GET /users
  # GET /users.json
  def index
    friends = Array.new
    @relationsip = Relationship.where('user1_id = ? AND status = ?', session[:current_user_id], "Accept")
    @relationsip.each do |relationsip|
      friends.push(relationsip.user2_id)
    end
    if friends.size == 0
      @users = User.where.not('id = ? OR active = ? OR role = ?', session[:current_user_id], 0, 0)
    else
      @users = User.where.not('id IN (?) OR id = ? OR active = ? OR role = ?', friends, session[:current_user_id], 0, 0)
    end
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.profilepic = '/images/avatar.png'
    @user.role = 1
    @user.active = 1

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to @user
    else
      render :new 
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.id == session[:current_user_id]
      if @user.update(user_params)
        redirect_to @user
      else
        render :edit
      end
    else
      redirect_to relationships_path, notice: 'You are not allow to modify the data of other users.'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    current_user = User.find_by_id(session[:current_user_id])
    if current_user.role == 0 || @user.id == current_user.id
      if User.destroy(@user.id)
        redirect_to root_path
      else
        redirect_to posts_path, notice: 'User was not successfully destroyed.'
      end
    end
  end

  def delete
    if @user.update(active: 0)
      redirect_to logout_path
    else
      redirect_to @user, notice: 'Something was wrong'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :nick, :profilepic, :role)
    end

end
