class RemoveUnecessaryFieldsFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :address_1
    remove_column :locations, :city
    remove_column :locations, :state
    remove_column :locations, :zipcode
    remove_column :locations, :country
    add_column :locations, :address, :string
    remove_column :locations, :address_for_geocoder
  end
end
