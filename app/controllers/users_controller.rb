class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password)
    @user = User.create(user_params)

    redirect_to root_path
  end

end
