class AddColumnToDonors < ActiveRecord::Migration[5.2]
  def change
    add_column :donors, :provider, :string
  end
end
