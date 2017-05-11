class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:email]
    if @user.active == 0
      flash[:notice] = "This account was deleted."
      render :new
    elsif !@user
      flash[:notice] = "Email #{params[:email]} was invalid"
      render :new
    elsif @user.password == params[:password]
      session[:current_user_id] = @user.id
      redirect_to posts_path
    else
      flash[:notice] = "Password was incorrect!"
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to :root
  end

  def index
    current_user = User.find_by_id(session[:current_user_id])
  end
end
