class AppointmentsController < ApplicationController
    before_action :require_logged_in
    before_action :current_donor
    #before_action :redirect_if_not_logged_in!


    def index
        @donor = Donor.find(params[:donor_id])
    end

    def new 
        #binding.pry
        if params[:clinic_id]
            @clinic = Clinic.find(params[:clinic_id])
            params[:donor_id] = current_donor.id
            @appointment = Appointment.new( :clinic_id => params[:clinic_id], :donor_id => params[:donor_id])
        else
        #if @donor  
            @donor = Donor.find(params[:donor_id])
            @appointment = Appointment.new( :donor_id => params[:donor_id])
            @clinics = Clinic.all
        #else
            #@clinic = Clinic.find(params[:clinic_id])
           # @appointment = Appointment.create( :clinic_id => params[:clinic_id])
            #@donor
        end
    end
    
    def create
        #binding.pry
        #if @donor
        #if params[:clinic_id]
     
            #@appointment = Appointment.new(appointment_params)
            #@appointment.donor_id = current_donor.id
            #@appointment.clinic_id = params[:clinic_id]
            #binding.pry
            #if @appointment.save
               #params[:clinic_id] ? redirect_to (clinic_appointment_path(@appointment.clinic_id, @appointment)) : redirect_to (donor_appointment_path(@appointment.donor_id, @appointment))
               #redirect_to clinic_appointment_path(@appointment.clinic_id, @appointment)
               #if params[:clinic_id]
                #redirect_to (clinic_appointment_path(@appointment.clinic_id, @appointment))
               #else
                #redirect_to (donor_appointment_path(@appointment.donor_id, @appointment))
               #end
            #else
                #render plain: "There was an error!"
           #end

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
    def appointment_params
        params.require(:appointment).permit(:datetime, :donor_id, :clinic_id)
    end

end

