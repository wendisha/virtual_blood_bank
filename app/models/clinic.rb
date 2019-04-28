class Clinic < ApplicationRecord
    has_many :appointments
    has_many :donors, through: :appointments
    #Scope method to find clinics in the same state as the donor
    scope :clinics_near_me, -> (current_donor){ where(state: current_donor.state) }
end

