class DonorsController < ApplicationController
    #Make sure user is logged in before all actions, except when creating a new user
    before_action :require_logged_in, except: [:new, :create]

    def new
        @donor = Donor.new
    end

    def create
        if auth
            @donor = Donor.find_by(uid: auth["uid"])
            if @donor 
                session[:donor_id] = @donor.id
                redirect_to donor_path(@donor)
            else 
                @donor.new_donor_from_auth(auth)
                if @donor.save
                    session[:donor_id] = @donor.id
                    redirect_to donor_path(@donor)
                else
                    raise @donor.errors.full_messages.inspect
                end
            end
        else 
            @donor = Donor.find_by(username: params[:donor][:username])
            if @donor && @donor.authenticate(params[:donor][:password])
                   session[:donor_id] = @donor.id
                redirect_to donor_path(@donor), notice: "Welcome back to the Virtual Blook Bank!"
            else
                 redirect_to signin_path
            end
        end
    end

    def show
        @donor = Donor.find_by_id(params[:id])
    end
 
    # whitelist the permitted params when sending form data to the db
    private
    def donor_params
        params.require(:donor).permit(:username, :password, :blood_type, :age, :state)
    end
end