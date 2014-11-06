class AddImgUrlColumn < ActiveRecord::Migration
  def change
    add_column :properties, :img_url, :string
  end
end
