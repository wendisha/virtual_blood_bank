class AddNameImageEmailColumnsToDonors < ActiveRecord::Migration[5.2]
  def change
    add_column :donors, :name, :string
    add_column :donors, :email, :string
    add_column :donors, :image, :string
  end
end
