class AddSearchIndexToItems < ActiveRecord::Migration[5.0]
  def up
    execute "create index item_name on items using gin(to_tsvector('simple', name))"
    execute "create index item_description on items using gin(to_tsvector('simple', description))"
  end

  def down
    execute "drop index item_name"
    execute "drop index item_description"
  end
end
