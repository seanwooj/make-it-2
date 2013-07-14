class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :address_for_geocoder
      t.integer :user_id

      t.timestamps
    end
  end
end
