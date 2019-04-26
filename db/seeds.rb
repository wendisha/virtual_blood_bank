# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Clinic.destroy_all

10.times do |index|
  Clinic.create!(name: Faker::Lorem.sentence(3),
                        state: Faker::Address.state_abbr)
end

blood_types = [{blood_type: "A+"},
         {blood_type: "O+"},
         {blood_type: "B+"},
         {blood_type: "AB+"},
         {blood_type: "A-"},
         {blood_type: "O-"},
         {blood_type: "B-"},
         {blood_type: "AB-"}]

blood_types.each do |blood_type|
  BloodType.create(blood_type)
end

