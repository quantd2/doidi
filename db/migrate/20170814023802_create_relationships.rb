class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :demander_id
      t.integer :granter_id

      t.timestamps
    end

    add_index :relationships, :demander_id
    add_index :relationships, :granter_id
    add_index :relationships, [:demander_id, :granter_id], unique: true
  end
end
