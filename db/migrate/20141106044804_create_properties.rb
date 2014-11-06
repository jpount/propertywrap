class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :unit_no
      t.integer :street_no
      t.string :street
      t.string :post_code
      t.string :city
      t.string :country
      t.string :lat
      t.string :lon
      t.string :property_type
      t.integer :no_of_beds
      t.integer :no_of_baths
      t.integer :no_of_carspaces
      t.date :purcahse_date

      t.timestamps
    end
  end
end
