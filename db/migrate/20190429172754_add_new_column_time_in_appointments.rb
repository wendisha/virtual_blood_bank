class AddNewColumnTimeInAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :time, :time
  end
end
