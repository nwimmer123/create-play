class UsersController < ApplicationController

  before_action :logged_in?, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index

  end

  def new
    
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to my_profile_path
    else
      flash[:error] = "Email has already been taken"
      redirect_to '/signup'
    end
  end

  def profile
    @user = current_user
    @games = Game.find_by_user_id(current_user.id)
   
  end

  def show
  end

  def edit
    if !authorized?(@user)
      flash[:notice] = "You do not have access to edit profiles that are not your own."
      redirect_to root_path
    end
  end

  def update
    if !authorized?(@user)
      flash[:notice] = "You do not have access to update profiles that are not your own."
      redirect_to root_path
    end
    current_params = params.require(:user).permit(:first_name, :last_name, :current_city)
    @user.update_attributes(current_params)
    redirect_to my_profile_path
  end






private

  def user_params
    params.require(:user).permit(:first_name, :email, :last_name, :password, :password_confirmation, :current_city)
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end
end
