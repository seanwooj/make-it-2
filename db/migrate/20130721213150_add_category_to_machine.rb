class AddCategoryToMachine < ActiveRecord::Migration
  def change
    add_column :machines, :category, :string
  end
end
