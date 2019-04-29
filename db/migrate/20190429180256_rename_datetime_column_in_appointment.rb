class RenameDatetimeColumnInAppointment < ActiveRecord::Migration[5.2]
  def change
    rename_column :appointments, :datetime, :date if column_exists?(:appointments, :datetime) && !column_exists?(:appointments, :date)
  end
end
