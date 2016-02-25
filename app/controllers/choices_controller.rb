class ChoicesController < ApplicationController

  def index
  end

  def new
    @choice = Choice.new 
    @game = Game.find_by_id(params[:game_id])
  end

  def create

    @game = Game.find_by_id(params[:game_id])
    choice_params = params.require(:choice).permit(:story, :choice_a_text, :choice_a_id, :choice_b_text, :choice_b_id, :game_id)
    @choice = Choice.new(choice_params.merge(game_id: @game.id))
    @choice.save

      #binding.pry
    if @game.starting_choice_id == nil 
      @game.starting_choice = @choice
      @game.save
    else
      #fix me
      #@choice.choice_a = @choice
      @choice.save
    end

    redirect_to edit_choice_path(@choice.game_id,@choice) 

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

  def new_child
  end

end

## When I create a new choice it needs to create a new node, same in games
# def new_a
#   parent = Choice.find_by_id()
#   child = Choice.create()
#   parent.choice_a = child
#   redirect_to choices_edit(child)
# end
