class AppointmentsController < ApplicationController
    before_action :require_logged_in
    before_action :current_donor
    before_action :redirect_if_not_logged_in!


    def index
        @donor = Donor.find(params[:donor_id])
    end

    def new 
        if @donor  
            @donor = Donor.find(params[:donor_id])
            @appointment = Appointment.create( :donor_id => params[:donor_id])
            @clinics = Clinic.all
        else
            @clinic = Clinic.find(params[:clinic_id])
            @appointment = Appointment.create( :clinic_id => params[:clinic_id])
            #@donor
        end
    end
    
    def create
        if @donor
            @appointment = Appointment.new(appointment_params)
            @appointment.donor_id = params[:donor_id]
            if @appointment.save
                redirect_to donor_appointment_path(@appointment.donor_id, @appointment)
            else
                render plain: "There was an error!"
            end
        else
            @appointment = Appointment.new(appointment_params)
            @appointment.clinic_id = params[:clinic_id]
            @appointment.donor_id = current_donor.id
            if @appointment.save
                redirect_to clinic_appointment_path(@appointment.clinic_id, @appointment)
            else
                render plain: "There was an error!"
            end
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

