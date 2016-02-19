class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :choiceA_id
      t.text :choiceAtext
      t.integer :choiceB_id
      t.text :choiceBtext
      t.text :story

      t.timestamps null: false
    end
  end
end
