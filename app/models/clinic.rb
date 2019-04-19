class Clinic < ApplicationRecord
    has_many :appointments
    has_many :donors, through: :appointments
    scope :clinics_near_me, -> { where("state = ?", @current_donor.state)}


end

