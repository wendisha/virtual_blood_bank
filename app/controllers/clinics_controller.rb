class ClinicsController < ApplicationController

    #List all existing clinics
    def index
        @clinics = Clinic.all
        @donor = current_donor.id
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
    end
end