class CreateFeedbackMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback_messages do |t|
      t.string :name
      t.string :email
      t.string :concerning
      t.text :content
      t.timestamps
    end
  end
end
