class CreateDonors < ActiveRecord::Migration[5.2]
  def change
    create_table :donors do |t|
      t.string :username
      t.string :password_digest
      t.string :blood_type
      t.integer :age
      t.string :state

      t.timestamps
    end
  end
end
