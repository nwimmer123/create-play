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
    render :show
  end

  def show
  end




private

  def user_params
    params.require(:user).permit(:first_name, :email, :last_name, :password, :password_confirmation, :current_city)
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end
end
