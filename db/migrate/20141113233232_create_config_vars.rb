class CreateConfigVars < ActiveRecord::Migration
  def change
    create_table :config_vars do |t|
      t.string :config_type
      t.text :config_value
      t.timestamps
    end
  end
end
