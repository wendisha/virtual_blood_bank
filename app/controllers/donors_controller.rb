class DonorsController < ApplicationController
    before_action :require_logged_in
    
    def new
        @donor = Donor.new
        @blood_types = ["A+", "O+", "B+", "AB+", "A-", "O-", "B-", "AB-"]
    end

    def create
        @donor = Donor.new(donor_params)
        if @donor.save
            #log user in
            session[:donor_id] = @donor.id
            flash[:message] = "Successfully Signed Up!"
            redirect_to donor_path(@donor)
        else
            #because of rendering, not redirecting
            #remember instance variables can only persist for one request
            render :new
        end
    end

    def self.create_with_omniauth(auth)
        donor = find_or_create_by(uid: auth[‘uid’], provider:  auth[‘provider’])
        donor.email = “#{auth[‘uid’]}@#{auth[‘provider’]}.com”
        donor.password = auth[‘uid’]
        donor.name = auth[‘info’][‘name’]
        if Donor.exists?(donor)
            donor
        else
            donor.save!
            donor
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
