class ChangeColumnDatatypeForDatetime < ActiveRecord::Migration[5.2]
  def change
    change_column :appointments, :datetime, :date
  end
end
