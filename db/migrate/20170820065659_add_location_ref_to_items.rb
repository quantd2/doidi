class AddLocationRefToItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :location, index: true, foreign_key: true
  end
end
