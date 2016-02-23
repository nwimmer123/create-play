class ChoicesController < ApplicationController
#// make a global incrementer to track choice_ids 
  def index
  end

  def new
    @choice = Choice.new 
  end

  def create
    choice_params = params.require(:choice).permit(:story, :choice_a_text, :choice_a_id, :choice_b_text, :choice_b_id, :game_id)
    @choice = Choice.new(choice_params)
    @choice.save
    p @choice.inspect
    redirect_to new_choice_path(@choice) #with id of the clikled edit path

  end

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
