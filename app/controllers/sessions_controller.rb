class SessionsController < ApplicationController

    def new
        @donor = Donor.new
    end

    def create
        @donor = Donor.find_by(username: params[:donor][:username])
        if @donor && @donor.authenticate(params[:donor][:password])
            session[:donor_id] = @donor.id
            redirect_to donor_path(@donor), notice: "Welcome back to the Virtual Blook Bank!"
        else
            redirect_to signin_path
        end

    end

end
