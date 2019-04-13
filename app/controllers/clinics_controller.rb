require 'pry'
class ClinicsController < ApplicationController
    def index
        #binding.pry
        #if params[:donor_id]
            #@clinics = Donor.find(params[:clinic_id]).clinics
        #else
            @clinics = Clinic.all
        #end
    end

    def show
        @clinic = Clinic.find_by_id(params[:id])
    end
end