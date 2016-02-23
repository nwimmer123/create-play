class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    puts 'new called'
    @game = Game.new
  end

  def show
    puts 'show called'
    @game = Game.find_by_id(params[:id])
  end

  def create
    game_params = params.require(:game).permit(:title, :backstory, :user_id, :starting_choice_id)
    @game = Game.new(game_params.merge(user_id: session[:user_id]))
    @game.save
    redirect_to new_choice_path(@game.id)
  end

  def edit
    @game = Game.find_by_id(params[:id])
  end

  def update
    game_params = params.require(:game).permit(:title, :backstory, :user_id, :starting_choice_id)
    @user.update_attributes(current_params)
  end



end



