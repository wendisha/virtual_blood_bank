class DonorsController < ApplicationController
    def new
        @donor = Donor.new
    end

    def create
        @donor = Donor.new(donor_params)
        if @donor.save
          session[:donor_id] = @donor.id
          flash[:message] = "Successfully Signed Up!"
          redirect_to donors_path
        else
          render :new
        end
    end
 
    # whitelist the permitted params when sending form data to the db
    private
    def donor_params
        params.require(:donor).permit(:username, :password, :blood_type, :age, :state)
    end

end
