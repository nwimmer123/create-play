class Choice < ActiveRecord::Base
  belongs_to :game

  belongs_to :choiceA, class_name: "Choice", foreign_key: "choiceA_id"
  belongs_to :choiceB, class_name: "Choice", foreign_key: "choiceB_id"

  #has_one :parent_choice, class_name: "Choice"
  has_one :parent_choice,  class_name: 'Choice', foreign_key: 'choiceA_id'
  #has_one :parent_choice, 
end
