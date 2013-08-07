class AddIndexesForRelations < ActiveRecord::Migration
  def change
    add_index :locations, :user_id
    add_index :machines, :user_id
  end
end
