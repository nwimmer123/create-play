class AddAncestryToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :ancestry, :string
    add_index :choices, :ancestry
  end
end
