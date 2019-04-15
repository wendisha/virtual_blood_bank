class AppointmentsController < ApplicationController

    def index
        @donor = Donor.find(params[:donor_id])
    end

    def new  
        @donor = Donor.find(params[:donor_id])
        @appointment = Appointment.create( :donor_id => params[:donor_id])
        @clinics = Clinic.all
    end
    
    def create
        #binding.pry
        @appointment = Appointment.new(appointment_params)
        @appointment.donor_id = params[:donor_id]
        if @appointment.save
            #binding.pry
            redirect_to donor_appointment_path(@appointment.donor_id, @appointment)
        else
            render plain: "There was an error!"
        end

    end

    def show
        @appointment = Appointment.find(params[:id])
    end

    private
    def appointment_params
        params.require(:appointment).permit(:datetime, :donor_id, :clinic_id)
    end


end

