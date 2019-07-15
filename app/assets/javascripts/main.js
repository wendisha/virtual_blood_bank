const homeUrl = 'http://localhost:3000/'

//Document ready function to hijack the click or submit events
//The $ is a shortcut for jQuery, and provides an interface to the library.
$(() => {
    listenForAllClinicsClick();
    listenForClinic();
    listenForNewApptSubmission();
});

//Clear html to repaint the DOM
const clearDom = () => {
    $('#app-container').html('');
}

const listenForAllClinicsClick = () => {  
    //Listen for click on link with all_clinics class, and use callback function that takes an e (event) parameter
    $('.all_clinics').on('click', (e) => {
        //Prevent default behavior
        e.preventDefault();
        //Allow url to update adding clinics at the end
        let url = homeUrl + "clinics";
        history.pushState(null, null, url);
        getClinics();
    });  
};

const listenForClinic = () => {
    $(document).on('click', '.show_link', function(e) {
        e.preventDefault();
        clearDom();
        let id = $(this).attr('data-id')
        let url = homeUrl + "clinics/" + id;
        history.pushState(null, null, url)
        fetch(`${id}.json`)
        .then(response => response.json())
        .then(clinic => {
            let newClinic = new Clinic(clinic);
            let clinicContent = newClinic.formatShow();
            $('#app-container').append(clinicContent);
        })
    });
}

const listenForNewApptSubmission = () => {
    $(".new_appointment").on("submit", function(e) {      
        e.preventDefault();
        //Grab the values entered in the form, using Serialize:
        const values = $( this ).serialize()
        let donorId = $('.apptDonorId').data('appt-donor-id')
        $.post(`/donors/${donorId}/appointments`, values).done(function(data) {
            $('#app-container').html('')
            const newAppointment = new Appointment(data)
            const htmlToAdd = newAppointment.formatAppointment()
            $('#app-container').append(htmlToAdd)
        })
    });
}

// const showAppts = () => {
//     $(document).on('ready', 'show-appointments', function(e) {
//         //Prevent default behavior
//         //e.preventDefault();    
//     });
// }

//Constructor function (use response we get from server and use a JS Model Object)
function Clinic(clinic) {
    this.id = clinic.id;
    this.name = clinic.name;
    this.state = clinic.state;
}

function Appointment(appointment) {
    this.id = appointment.id;
    this.donor_id = appointment.donor_id;
    this.clinic_id = appointment.clinic_id;
    this.date = appointment.date;
    this.time = appointment.time;
    this.donor_username = appointment.donor_username
}

//Prototype function (similar to instance methods) to format our clinics
Clinic.prototype.formatIndex = function() {
    //Template strings to advoid strings concatenation
    let clinicHtml = `
    <section class="container text-left">
        <h4 class="font-weight-light"><strong>Clinic: </strong><a href="/clinics/${this.id}" data-id="${this.id}" class="show_link">${this.name}</a></h4>
    </section>
    `
    return clinicHtml;
}

//Prototype functions (similar to instance methods):
Clinic.prototype.formatShow = function() {
    let clinicHtml = `
    <section class="jumbotron text-center" >
        <h2 class="display-4">Clinic's Details</h2>
    </section><br>
    <section class="container">
        <h4 class="font-weight-light"><strong>Name: </strong>${this.name}</h4>
        <h4 class="font-weight-light"><strong>State: </strong>${this.state}</h4><br><br>
        <h4 class="font-weight-light all_clinics"><a href="/clinics"><strong>Go Back To See All Clinics</strong></a></h4>
    `
    return clinicHtml;
}

Appointment.prototype.formatAppointment = function() {
    let appointmentHtml = `
    <section class="jumbotron text-center">
        <h2 class="display-4">Appointment's Details</h2>
    </section><br>
    <section class="container">
        <h4 class="font-weight-light"><strong>Username: ${this.donor_username}<br></strong></h4>
        <h4 class="font-weight-light"><strong>Clinic: ${this.clinic_id}<br></strong></h4>
        <h4 class="font-weight-light"><strong>Date: ${this.date}<br></strong></h4>
        <h4 class="font-weight-light"><strong>Time: ${this.time}<br></strong></h4>
    </section><br>
    `
    return appointmentHtml;
}

Appointment.prototype.formatAppointmentsIndex = function() {
    let appointmentHtml = `
    <section class="container text-left">
        <h5 class="font-weight-light text-center"><strong>Date: </strong><a href="/donors/${this.donor_id}/appointments/${this.id}" data-id="${this.id}" class="show_link">${this.date}</a></h5>
    </section>
    `
    return appointmentHtml;
}

const getClinics = () => {
    //Whenever we use fetch (native API to the browser called on the global object), we get back a promise that will be resolved or rejected. 
    //Since we wrote the backend API, it will be resolved.
        fetch(`/clinics.json`)
            //Use #then to get the response object and call #json to convert it and extract/parse the data that we want
            .then(response => response.json())
            //Return the data we got in a following then method. Call it clinics, to be semantic
            .then(clinics => {
                clearDom();
                //Iterate over all the clinics
                clinics.forEach(clinic => {
                    //Use constructor function to create clinic objects
                    let newClinic = new Clinic(clinic);
                    let clinicContent = newClinic.formatIndex();
                    $('#app-container').append(clinicContent);
                })
            })    
}

// const getClinic = () => {
//     let id = $(this).attr('data-id')

// }

const getAppointments = () => {
    let donorId = $('.donor-show').data('donor-id')
    fetch (`/donors/${donorId}/appointments.json`)
    .then(response => response.json())
    .then(appointments => {
        appointments.forEach(appointment => {
            let newAppt = new Appointment(appointment);
            let appointmentHtml = newAppt.formatAppointmentsIndex();
            $('#show-appointments').append(appointmentHtml);
        })
    })    
}