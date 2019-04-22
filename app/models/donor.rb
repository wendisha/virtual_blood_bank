class Donor < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :blood_type, presence: true
    has_secure_password
    has_many :appointments
    has_many :clinics, through: :appointments

end
