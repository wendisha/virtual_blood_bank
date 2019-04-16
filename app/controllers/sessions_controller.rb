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
    
    def create_from_omniauth
        @donor = Donor.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
        end
        session[:donor_id] = @donor.id
        render 'static_pages/home'
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

    private
 
    def auth
      request.env['omniauth.auth']
    end

end
