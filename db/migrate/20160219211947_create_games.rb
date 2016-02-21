class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :title
      t.integer :starting_choice_id
      t.boolean :published
      t.text :backstory
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
