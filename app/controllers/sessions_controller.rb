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
                oauth_email = request.env["omniauth.auth"]["info"]["email"]
                oauth_name = request.env["omniauth.auth"]["info"]["name"]
                oauth_image = request.env["omniauth.auth"]["info"]["image"]
                oauth_username = "#{oauth_name.downcase.split.join('_')}_#{Random.new.rand(99999)}"
                oauth_blood_type = "Non-Assigned"
                oauth_uid = request.env["omniauth.auth"]["uid"]
                oauth_provider = request.env["omniauth.auth"]["provider"]
                #remember to handle the password
                @donor = Donor.new(
                    :name => oauth_name, 
                    :email => oauth_email, 
                    :password_digest => '45ladsog', 
                    :image => oauth_image, 
                    :username => oauth_username,
                    :blood_type => oauth_blood_type,
                    :uid => oauth_uid,
                    :provider => oauth_provider
                    )
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

    
    #def create_from_omniauth
        #@donor = Donor.find_or_create_by(uid: auth['uid']) do |u|
            #u.name = auth['info']['name']
            #u.email = auth['info']['email']
           # u.image = auth['info']['image']
        #end
        #session[:donor_id] = @donor.id
       # if logged_in?
           # flash[:message] = "Successfully authenticated via Google!"
          #else
            #flash[:message] = "Something went wrong. Try again."
          #end
        #render 'static_pages/home'
    #end
   
        #if request.env['omniauth.auth']
          #donor = Donor.create_with_omniauth(request.env['omniauth.auth'])
          #session[:donor_id] = donor.id    
          #redirect_to donor_path(donor.id)
        #else
            #donor = Donor.find_by_email(params[:email])
            #donor && user.authenticate(params[:password])
          #session[:donor_id] = donor.id
          #redirect_to donor_path(donor.id)
        #end
      #end

    def destroy
        session.clear
        redirect_to root_path
    end

    private
 
    def auth
      request.env['omniauth.auth']
    end

end
