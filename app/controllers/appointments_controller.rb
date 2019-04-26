class AppointmentsController < ApplicationController
    before_action :require_logged_in
    before_action :current_donor
    #before_action :authenticate_donor? 
    #before_action :redirect_if_not_logged_in!

    def index
        @donor = Donor.find(params[:donor_id]) 
    end

    #Identify if nested resource is under clinic or donor, get appropiate parameters
    def new 
        #@donor = Donor.find(params[:donor_id])
        #redirect_to root_path if !authenticate_donor?(@donor)
        if params[:clinic_id]
            @clinic = Clinic.find(params[:clinic_id])
            params[:donor_id] = current_donor.id
            @appointment = Appointment.new( :clinic_id => params[:clinic_id], :donor_id => params[:donor_id])
        else
            @donor = Donor.find(params[:donor_id])
            redirect_to root_path if !authenticate_donor?(@donor)
            @appointment = Appointment.new( :donor_id => params[:donor_id])
            @clinics = Clinic.all
        end
    end
    
    #Identify if nested resource is under clinic or donor, get appropiate parameters to create appt, and redirect accordingly 
    def create
        if params[:clinic_id]
            @appointment = Appointment.new(appointment_params)
            @appointment.clinic_id = params[:clinic_id]
            @appointment.donor_id = current_donor.id
            if @appointment.save
                redirect_to clinic_appointment_path(@appointment.clinic_id, @appointment)
            else
                render plain: "There was an error!"
            end
        else
            @appointment = Appointment.new(appointment_params)
            @appointment.donor_id = current_donor.id
            if @appointment.save
                redirect_to (donor_appointment_path(@appointment.donor_id, @appointment))
            else
                render plain: "There was an error!"
            end
        end
    end

    def show
        @appointment = Appointment.find(params[:id])
    end

    private

    # whitelist the permitted params when sending form data to the db
    def appointment_params
        params.require(:appointment).permit(:datetime, :donor_id, :clinic_id)
    end
end