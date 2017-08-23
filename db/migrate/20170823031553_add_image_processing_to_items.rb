class AddImageProcessingToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :image_processing, :boolean, null: false, default: false
  end
end
