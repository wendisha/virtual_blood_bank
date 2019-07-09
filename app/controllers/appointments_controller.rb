class AppointmentsController < ApplicationController
    before_action :require_logged_in
    before_action :current_donor
    #make it so clinic is not automatically selected

    def index
        @donor = Donor.find(params[:donor_id]) 
        respond_to do |f|
            #Render html for the clinic's index erb file
            f.html #{render :index}
            #Get JSON representation of all of the clinics
			f.json {render json: @donor.appointments}
		end
    end

    #Identify if nested resource is under clinic or donor, get appropiate parameters
    def new
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
                #redirect_to clinic_appointment_path(@appointment.clinic_id, @appointment)
                render json: @appointment
            else
                render plain: "There was an error!"
            end
        else
            @appointment = Appointment.new(appointment_params)
            @appointment.donor_id = current_donor.id
            if @appointment.save 
                #redirect_to (donor_appointment_path(@appointment.donor_id, @appointment))
                render json: @appointment
            else
                render plain: "There was an error!" #render new
            end
        end
    end

    def edit
        @appointment = Appointment.find(params[:id])
        if params[:clinic_id]
            @clinic = Clinic.find(params[:clinic_id])
            params[:donor_id] = current_donor.id
        else
            @donor = Donor.find(params[:donor_id])
            redirect_to root_path if !authenticate_donor?(@donor)
            @clinics = Clinic.all
        end
    end

    def update
        if params[:clinic_id]
            @appointment = Appointment.find(params[:id])
            @appointment.update(appointment_params)
            if @appointment.save
                redirect_to clinic_appointment_path(@appointment.clinic_id, @appointment)
            else
                render plain: "There was an error!"
            end
        else
            @appointment = Appointment.find(params[:id])
            @appointment.update(appointment_params)
            if @appointment.save 
                redirect_to (donor_appointment_path(@appointment.donor_id, @appointment))
            else
                render plain: "There was an error!" #render new
            end
        end
    end

    def show
        if params[:clinic_id]
            @appointment = Appointment.find(params[:id])
        else
            @donor = Donor.find(params[:donor_id])
            if @donor.id == current_donor.id
                @appointment = Appointment.find(params[:id])
            else
                render plain: "You are not authorized!"
            end
        end
    end

    private

    # whitelist the permitted params when sending form data to the db
    def appointment_params
        params.require(:appointment).permit(:date, :time, :donor_id, :clinic_id)
    end
end