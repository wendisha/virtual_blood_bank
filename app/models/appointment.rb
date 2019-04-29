class Appointment < ApplicationRecord
    belongs_to :donor 
    belongs_to :clinic
    validates :clinic_id, presence: true
    validates :date, presence: true
    validates :time, presence: true
end
