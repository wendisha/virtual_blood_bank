class ClinicsController < ApplicationController
    def index
        @clinics = Clinics.all
    end
end