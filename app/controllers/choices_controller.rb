class ChoicesController < ApplicationController
#// make a global incrementer to track choice_ids 
  def index
  end

  def new
    @choice = Choice.new # instantiate first choice as 1
    # subsequent choices are choiceA_id =  @choice.choice_A_id += 1;
    aAssign(@choice.choiceA_id)
    bAssign(@choice.choiceB_id)
  end

  def aAssign(data)
    p "PREVIOUS CHOICEA_ID #{data}"

    if @choice.choiceA_id == nil
      @choice.choiceA_id = 1
    else
      @choice.choiceA_id += 1
    end
    p "FINAL CHOICEA_ID #{@choice.choiceA_id}"
  end

  def bAssign(data)
    if @choice.choiceB_id == nil
      @choice.choiceB_id = 2
    else
      @choice.choiceB_id +=1
    end

  end

  def create
    choice_params = params.require(:choice).permit(:story, :choiceAtext, :choiceA_id, :choiceBtext, :choiceB_id, :game_id)
    @choice = Choice.new(choice_params.merge(game_id: @gameid))
    @choice.save
    p @choice.inspect
    redirect_to new_choice_path(@choice) #with id of the clikled edit path

  end



end
