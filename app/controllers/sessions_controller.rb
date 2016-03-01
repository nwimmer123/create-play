class SessionsController < ApplicationController
  before_action :logged_in?, only: [:destroy]
  before_action :logged_out?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.confirm(user_params)
    if @user
      login(@user)
      redirect_to my_profile_path
    else
      flash[:error] = "Incorrect email or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end