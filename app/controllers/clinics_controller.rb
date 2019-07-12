class ClinicsController < ApplicationController

    #List all existing clinics
    def index
        #Grab all clinics using ActiveRecord
        @clinics = Clinic.all
        @donor = current_donor.id
        respond_to do |f|
            #Render html for the clinic's index erb file
            f.html {render :index}
            #Get JSON representation of all of the clinics
			f.json {render json: @clinics}
		end
    end

    #List all existing clinics in the same state as the donor
    def donors_clinics
        if current_donor
            @clinics = Clinic.clinics_near_me(current_donor)
        end
        @donor = current_donor.id
        if @clinics.empty?
            flash[:message] = "At this moment, there are no clinics in your area."
        end
    end

    #Show details of an specific clinic
    def show
        @clinic = Clinic.find_by_id(params[:id])
        @donor = current_donor.id
        respond_to do |f|
            #Render html for the clinic's show erb file
            f.html {render :show}
            #Get JSON representation of that specific clinic
			f.json {render json: @clinic}
		end
    end
end