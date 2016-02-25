class Choice < ActiveRecord::Base
  belongs_to :game

  belongs_to :choice_a, class_name: "Choice", foreign_key: "choice_a_id"
  belongs_to :choice_b, class_name: "Choice", foreign_key: "choice_b_id"

  #has_one :parent_choice, class_name: "Choice"
  #has_one :parent_choice,  class_name: 'Choice', foreign_key: 'choice_a_id'
  #has_one :parent_choice, 
  def parent
    parent = Choice.where("choice_a_id = ? OR choice_b_id = ?", self.id, self.id) 
    parent.empty? ? nil : parent.first
  end

  def has_parent?
    !parent.nil?
  end


end
