class ChoicesController < ApplicationController


  

  def index
  end

  def new
    @choice = Choice.new 
  end

  def create
    ##on second page creation, game id is changed to the user id in the path --WHY??
    gameid = params[:game_id]
    @game = Game.find_by_id(gameid)
    choice_params = params.require(:choice).permit(:story, :choice_a_text, :choice_a_id, :choice_b_text, :choice_b_id, :game_id)
    #debugger

    @choice = Choice.new(choice_params.merge(game_id: gameid))
 
    @choice.save

##if working, but on the second creation, @game is nil. why?
##it's still in the params

    if @choice.parent() == nil 
      ##this isn't working. triggered evthough it had a parent

      @game.starting_choice_id = @choice.id
      @game.save
    else
      @choice.choice_a = @choice.id
      @choice.save
    end

    redirect_to new_choice_path(@choice.id) #with id of the clikled edit path

  end

  #in create assigns chuld parents id
  #@choice = Choice.new(choice_params.merge(choice_a_id: params[:id]))

  def edit
    if @choice == nil
      @choice = Choice.new
    else
      @choice = Choice.find_by_id(params[:id])
    end
  end

  def update
    choice_params = params.require(:choice).permit(:story, :choice_a_text, :choice_a_id, :choice_b_text, :choice_b_id, :game_id)
    @choice.update_attributes(choice_params)
    redirect_to edit_choice_path(@choice.id)
  end

  def show
  end

end

## When I create a new choice it needs to create a new node, same in games
# def new_a
#   parent = Choice.find_by_id()
#   child = Choice.create()
#   parent.choice_a = child
#   redirect_to choices_edit(child)
# end
