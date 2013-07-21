class AddAttributesToMachine < ActiveRecord::Migration
  def change
    add_column :machines, :name, :string
    add_column :machines, :description, :text
  end
end
