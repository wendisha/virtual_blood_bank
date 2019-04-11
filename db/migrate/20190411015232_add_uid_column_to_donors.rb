class AddUidColumnToDonors < ActiveRecord::Migration[5.2]
  def change
    add_column :donors, :uid, :string
  end
end
