class ChoicesController < ApplicationController
#// make a global incrementer to track choice_ids 
  def index
  end

  def new
    @choice = Choice.new 
    
  end


  def create
    choice_params = params.require(:choice).permit(:story, :choiceAtext, :choiceA_id, :choiceBtext, :choiceB_id, :game_id)
    @choice = Choice.new(choice_params.merge(game_id: @gameid))
    @choice.save
    p @choice.inspect
    redirect_to new_choice_path(@choice) #with id of the clikled edit path

  end



end
