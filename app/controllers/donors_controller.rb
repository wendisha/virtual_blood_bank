class DonorsController < ApplicationController
    def create
        Donor.create(donor_params)
    end
 
    # whitelist the permitted params when sending form data to the db
    private
    def donor_params
        params.require(:donor).permit(:username, :password, :blood_type, :age, :state)
    end

end
