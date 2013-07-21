class AddUserIdToMachine < ActiveRecord::Migration
  def change
    add_column :machines, :user_id, :integer
  end
end
