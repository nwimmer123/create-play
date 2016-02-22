class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find_by_id(params[:id])
  end

  def start
    @user = current_user
    @games = Game.find_by_user_id(current_user.id)
  end

  def create
  end


end
