class AddEncestryToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :ancestry, :string
  end
end
