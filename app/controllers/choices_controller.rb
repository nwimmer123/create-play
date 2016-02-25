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

    if @game.starting_choice_id == nil 
      @game.starting_choice = @choice
      @game.save
    else
      @choice.save
    end

    #I need to assign the parent here, connect the current choice
    #a id with the hidden params id
    # if @choice.choice_a_id == nil
    #    @choice.choice_a = @parent.id
    #    @choice.save
    # end


    # p "PARENT? #{@parent}"
    # unless @parent.nil?
    #   @choice.choice_a = @parent.id
    # p "CHOICE #{@choice}"
    # p "CHOICE A #{@choice.choice_a}"
    # p "PARENT? #{@parent.id}" 
  #end

    redirect_to edit_choice_path(@choice.game_id,@choice) 

  end

  def edit
    @choice = Choice.find_by_id(params[:id])
  end

  def update
    @choice = Choice.find_by_id(params[:id])
    choice_params = params.require(:choice).permit(:story, :choice_a_text, :choice_a_id, :choice_b_text, :choice_b_id, :game_id)
    @choice.update_attributes(choice_params)
    redirect_to edit_choice_path(@choice.game_id, @choice)
  end

  def show
  end

  def create_child
    @parent_choice = Choice.find(params[:choice_id])
    @child_choice = Choice.create(game_id: params[:game_id])

    if params[:letter] == "a"
      @parent_choice.update!(choice_a_id: @child_choice.id)  
    elsif params[:letter] == "b"
      @parent_choice.update!(choice_b_id: @child_choice.id)  
    end
    
    redirect_to edit_choice_path(@child_choice.game_id, @child_choice.id)
  end

end

## When I create a new choice it needs to create a new node, same in games
# def new_a
#   parent = Choice.find_by_id()
#   child = Choice.create()
#   parent.choice_a = child
#   redirect_to choices_edit(child)
# end

