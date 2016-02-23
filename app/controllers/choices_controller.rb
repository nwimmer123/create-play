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

  def edit
  #   @choice = Choice.find_by_id(params(id))
  #   if @choice == nil
  #     @choice = Choice.new
  end

  def update
  end

  def show
  end

end


# def new_a
#   parent = Choice.find_by_id()
#   child = Choice.create()
#   parent.choice_a = child
#   redirect_to choices_edit(child)
# end
