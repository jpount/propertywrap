class AddColumn < ActiveRecord::Migration
  def change
    add_column :properties, :state, :string
  end
end
