class AddStatusToRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :status, :integer, default: 0
  end
end
