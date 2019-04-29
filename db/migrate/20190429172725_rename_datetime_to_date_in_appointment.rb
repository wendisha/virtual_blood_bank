class RenameDatetimeToDateInAppointment < ActiveRecord::Migration[5.2]
  def change
    rename_column :appoinments, :datetime, :date
  end
end
