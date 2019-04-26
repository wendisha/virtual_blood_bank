# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Clinic.destroy_all

30.times do |index|
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

states = [{state: "AL"},
         {state: "AK"},
         {state: "AZ"},
         {state: "AR"},
         {state: "CA"},
         {state: "CO"},
         {state: "CT"},
         {state: "DE"},
         {state: "FL"},
         {state: "GA"},
         {state: "HI"},
         {state: "ID"},
         {state: "IL"},
         {state: "IN"},
         {state: "IA"},
         {state: "KS"},
         {state: "KY"},
         {state: "LA"},
         {state: "ME"},
         {state: "MD"},
         {state: "MA"},
         {state: "MI"},
         {state: "MN"},
         {state: "MS"},
         {state: "MO"},
         {state: "MT"},
         {state: "NE"},
         {state: "NV"},
         {state: "NH"},
         {state: "NJ"},
         {state: "NM"},
         {state: "NY"},
         {state: "NC"},
         {state: "ND"},
         {state: "OH"},
         {state: "OK"},
         {state: "OR"},
         {state: "PA"},
         {state: "RI"},
         {state: "SC"},
         {state: "SD"},
         {state: "TN"},
         {state: "TX"},
         {state: "UT"},
         {state: "VT"},
         {state: "VA"},
         {state: "WA"},
         {state: "WV"},
         {state: "WI"},
         {state: "WY"}]

states.each do |state|
  State.create(state)
end