class ClinicsController < ApplicationController
    def index
        @clinics = Clinic.all
        @donor = current_donor.id
    end

    def donors_clinics
        if current_donor
            @clinics = Clinic.clinics_near_me(current_donor)
        end
        @donor = current_donor.id
    end

    def show
        @clinic = Clinic.find_by_id(params[:id])
        @donor = current_donor.id
    end
end



