class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
