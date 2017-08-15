class AddAncestryToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :ancestry, :string
  end
end
