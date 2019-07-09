class DonorsController < ApplicationController
    #Make sure donor is logged in before all actions, except when creating a new donor
    before_action :require_logged_in, except: [:new, :create]

    def new
        @donor = Donor.new
    end

    def create
        #Determine if donor is signing up through Facebook
        if auth
            #Check if donor has logged in before
            @donor = Donor.find_by(uid: auth["uid"])
            if @donor 
                session[:donor_id] = @donor.id
                redirect_to donor_path(@donor)
            else 
                #If its a new donor, create it from helper method, auth
                @donor.new_donor_from_auth(auth)
                if @donor.save
                    session[:donor_id] = @donor.id
                    redirect_to donor_path(@donor)
                else
                    raise @donor.errors.full_messages.inspect
                end
            end
        else 
            #When signing up through the app, create donor from donor_params
            @donor = Donor.new(donor_params)
            if @donor.save
                #log user in
                session[:donor_id] = @donor.id
                flash[:message] = "Successfully Signed Up!"
                redirect_to donor_path(@donor)
            else
                render :new
            end
        end
    end

    def show
        @donor = Donor.find_by_id(params[:id])
        respond_to do |f|
            #Render html for the clinic's show erb file
            f.html
            #Get JSON representation of that specific clinic
			f.json {render json: @donor}
		end
    end
 
    #Whitelist the permitted params when sending form data to the db
    private
    def donor_params
        params.require(:donor).permit(:username, :password, :blood_type, :age, :state)
    end
end