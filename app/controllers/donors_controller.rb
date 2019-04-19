class DonorsController < ApplicationController
    def new
        @donor = Donor.new
    end

    def create
        @donor = Donor.new(donor_params)
        if @donor.save
            #loggin in user
          session[:donor_id] = @donor.id
          flash[:message] = "Successfully Signed Up!"
          #binding.pry
          redirect_to donor_path(@donor)
        else
            #because of rendering, not redirecting
          render :new
        end
    end

    def show
        @donor = Donor.find_by_id(params[:id])
        
        #@message = params[:message]
    end

 
    # whitelist the permitted params when sending form data to the db
    private
    def donor_params
        params.require(:donor).permit(:username, :password, :blood_type, :age, :state)
    end

end
