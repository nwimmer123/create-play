class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password)
    @user = User.create(user_params)

    redirect_to user_path(@user.id)
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

end
