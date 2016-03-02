module GamesHelper

  def current_game
    @game = Game.find_by_id(params[:id])
  end

end
