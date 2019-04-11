class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :donor_id
      t.integer :clinic_id
      t.datetime :datetime

      t.timestamps
    end
  end
end
