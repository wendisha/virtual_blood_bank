class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :destroy
    
    def new
        @donor = Donor.new
    end

    def create
        #Check if donor is signing in through Facebook
        if auth
            @donor = Donor.find_by(uid: auth["uid"])
            #Check if donor has already signed in through Facebook before and create session/redirect to donor's details page
            if @donor 
                session[:donor_id] = @donor.id
                redirect_to donor_path(@donor)
            else 
                #If not, create the donor, set session/redirect to donor's details page
                @donor = Donor.new_donor_from_auth(auth)
                if @donor.save
                    session[:donor_id] = @donor.id
                    redirect_to donor_path(@donor)
                else
                    raise @donor.errors.full_messages.inspect
                end
            end
        #If user is not signing in through Facebook, search for existing account
        else 
            @donor = Donor.find_by(username: params[:donor][:username])
            if @donor && @donor.authenticate(params[:donor][:password])
                session[:donor_id] = @donor.id
                flash[:message] = "Welcome back to the Virtual Blood Bank!"
                redirect_to donor_path(@donor)
            else
                flash[:message] = "Invalid username or password. Please try again."
                redirect_to signin_path
            end
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    private
 
    def auth
      request.env['omniauth.auth']
    end

end