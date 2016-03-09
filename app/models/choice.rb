class Choice < ActiveRecord::Base
  belongs_to :game

  belongs_to :choice_a, class_name: "Choice", foreign_key: "choice_a_id"
  belongs_to :choice_b, class_name: "Choice", foreign_key: "choice_b_id"

  def parent
    parent = Choice.where("choice_a_id = ? OR choice_b_id = ?", self.id, self.id) 
    parent.empty? ? nil : parent.first
  end

  def has_parent?
    !parent.nil?
  end

  def children
    children = Choice.where(id: [self.choice_a_id, self.choice_b_id].compact )
    children.empty? ? nil : children.first
  end

  def child_a
    Choice.find_by_id(self.choice_a_id)
  end

  def child_b
    Choice.find_by_id(self.choice_b_id)
  end

end
