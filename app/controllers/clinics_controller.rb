class ClinicsController < ApplicationController
    def index
        #create current_donor and get its state from it
        if current_donor
            @clinics = Clinic.clinics_near_me(current_donor)
        else
            #binding.pry
            @clinics = Clinic.all
        end
        @donor = current_donor.id
      end

    def show
        @clinic = Clinic.find_by_id(params[:id])
        @donor = current_donor.id
    end
end



