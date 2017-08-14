class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.belongs_to :user, index: true
      t.string :image

      t.timestamps
    end
  end
end
