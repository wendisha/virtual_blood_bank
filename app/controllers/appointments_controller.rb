class AppointmentsController < ApplicationController

    def new
        @appointment = Appointment.create( :donor_id => params[:donor_id])
        @clinics = Clinic.all
    end
    
end
