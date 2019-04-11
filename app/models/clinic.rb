class Clinic < 
    has_many :appointments
    has_many :donors, through: :appointments
end
