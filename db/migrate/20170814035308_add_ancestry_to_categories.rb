class AddAncestryToCategories < ActiveRecord::Migration[5.0]
  def self.up
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end

  def self.down
    remove_index :categories, :ancestry
    remove_column :categories, :ancestry
  end
end