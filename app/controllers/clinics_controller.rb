require 'pry'
class ClinicsController < ApplicationController
    def index
        #create current_donor and get its state from it
        if current_donor
            #current_donor.state
            #binding.pry
            @clinics = Clinic.clinics_near_me(current_donor)
        else
            #binding.pry
            @clinics = Clinic.all
        end
      end

    def show
        @clinic = Clinic.find_by_id(params[:id])
    end
end



