class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :fequency, :frequency
    rename_column :properties, :purcahse_date, :purchase_date
    rename_column :transactions, :outgoing, :outgoing_type

  end
end
