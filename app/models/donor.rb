class Donor < ApplicationRecord
    has_secure_password
    has_many :appointments
    has_many :clinics, through: :appointments

end
