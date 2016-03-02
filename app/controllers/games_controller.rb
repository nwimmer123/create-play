class GamesController < ApplicationController
  
  before_action :current_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
  end

  def create
    @game = Game.new(game_params.merge(user_id: session[:user_id]))
    @game.save
    redirect_to new_choice_path(@game.id)
  end

  def edit
  end

  def update
    @choice = Choice.find_by_id(params[:id])
    @game.update_attributes(game_params)
    redirect_to edit_choice_path(@game.id, @game.starting_choice_id)
  end

  def destroy
    @game.destroy
    redirect_to my_profile_path
  end

  private

  def game_params
    params.require(:game).permit(:title, :backstory, :user_id, :starting_choice_id)
  end

  def current_game
    @game = Game.find_by_id(params[:id])
  end


end



