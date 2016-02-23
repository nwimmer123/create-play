class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :choice_a_id
      t.text :choice_a_text
      t.integer :choice_b_id
      t.text :choice_b_text
      t.text :story
      t.belongs_to :game

      t.timestamps null: false
    end
  end
end
