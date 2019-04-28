class Donor < ApplicationRecord
    has_many :appointments
    has_many :clinics, through: :appointments
    validates :username, presence: true
    validates_uniqueness_of :username, :case_sensitive => false
    validates :blood_type, presence: true
    has_secure_password

    #Helper method to create donor when loggin in through Facebook for the first time
    def self.new_donor_from_auth(auth)
        Donor.new(
            :name => request.env["omniauth.auth"]["info"]["name"], 
            :email => request.env["omniauth.auth"]["info"]["email"], 
            :password_digest => '45ladsog', 
            :image => request.env["omniauth.auth"]["info"]["image"], 
            :username => "#{oauth_name.downcase.split.join('_')}_#{Random.new.rand(99999)}",
            :blood_type => "Non-Assigned",
            :uid => request.env["omniauth.auth"]["uid"],
            :provider => request.env["omniauth.auth"]["provider"]
        )
    end
end
