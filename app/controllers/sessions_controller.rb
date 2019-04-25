class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :destroy
    
    def new
        @donor = Donor.new
    end

    def create
        if auth
            @donor = Donor.find_by(uid: auth["uid"])
            if @donor 
                #binding.pry
                session[:donor_id] = @donor.id
                redirect_to donor_path(@donor)
            else 
                @donor = Donor.new_donor_from_auth(auth)
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

    def destroy
        session.clear
        redirect_to root_path
    end

    private
 
    def auth
      request.env['omniauth.auth']
    end

end