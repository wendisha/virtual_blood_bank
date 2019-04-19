require 'pry'
class ClinicsController < ApplicationController
    def index
        #create current_user and get its state from it
        if params[:state]
            #current_user.state
            @clinics = Clinic.clinics_near_me
        else
            @clinics = Clinic.all
        end
      end

    def show
        @clinic = Clinic.find_by_id(params[:id])
    end
end



