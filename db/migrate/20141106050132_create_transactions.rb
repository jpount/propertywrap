class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :income_type
      t.string :outgoing_type
      t.decimal :value
      t.string :fequency
      t.date :last_due
      t.integer :property_id

      t.timestamps
    end
  end
end
