class ClinicsController < ApplicationController
    def index
        #if params[:donor_id]
            #@clinics = Donor.find(params[:clinic_id]).clinics
        #else
            @clinics = Clinic.all
        #end
    end
end