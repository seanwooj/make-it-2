class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.boolean :has_machine

      t.timestamps
    end
  end
end
