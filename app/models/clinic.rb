class Clinic < ApplicationRecord
    has_many :appointments
    has_many :donors, through: :appointments
end
