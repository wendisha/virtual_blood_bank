//Document ready function to hijack the click event on the See All Clinics link on the donor's show page
//Arrow function!
$(() => {
    listenForClick();
});

// let donorId = function retrieveDonorId(){
//     console.log($('#all_appointments').data('donor-id'))
// }
  
const listenForClick = () => {
    //The $ is a shortcut for jQuery, and provides an interface to the library.
    //Listen for click on link with all_clinics class, and use callback function that takes an e (event) parameter
    $('.all_clinics').on('click', (e) => {
        //Prevent default behavior
        e.preventDefault();
        //Allow url to update adding clinics at the end
        const data = 'http://localhost:3000/'
        url = data + "clinics";
        history.pushState(null, null, url);
        //history.pushState(null, null, "clinics");
        getClinics();
    });
    
    $(document).on('click', '.show_link', function(e) {
        e.preventDefault();
        $('#app-container').html('')
        // console.log($(this).attr('data-id'))
        let id = $(this).attr('data-id')
        fetch(`clinics/${id}.json`)
            .then(response => response.json())
            //Return the data we got in a following then method. Call it clinics, to be semantic
            .then(clinic => {
                let newClinic = new Clinic(clinic);
                let clinicContent = newClinic.formatShow();
                $('#app-container').append(clinicContent);
            })
    });

    $("form").on("submit", function(e) {           //Why not with the new_appointment id?????????????????????
        e.preventDefault();
    //     //Grab the values entered in the form, using Serialize:
        const values = $( this ).serialize()
        let donorId = $('.apptDonorId').data('appt-donor-id')
        $.post(`/donors/${donorId}/appointments`, values).done(function(data){
            //console.log(data)
            $('#app-container').html('')
            //$('#app-container').html('<h1>New Appointment</h1>')
            const newAppointment = new Appointment(data)
        })
    });


    // $(document).on('submit', '#new-form', function(e) {
    //     e.preventDefault()
    //     //console.log('event preventend')
    //     const values = $(this).serialize()
    //     //console.log(values)
    //     let donorId = $('.apptDonorId').data('appt-donor-id')
    //     //console.log(donorId)
    //         $.post(`/donors/${donorId}/appointments`, values).done(function(data){
    //          console.log(data)
    //     //      const newEquipment = new Equipment(data)    
    //     //     const addToHtml = newEquipment.formatShow()
    //     //     $('#new-equipment').html(addToHtml)
    //     //     console.log('rendered new equipment')
    //     })
    // })
    
};
 

//Constructor function (use response we get from server and use a JS Model Object)
//Could have used a ES6 class
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
}

//Prototype function (similar to instance methods) to format our clinics
Clinic.prototype.formatIndex = function() {
    //Template strings to advoid strings concatenation
    let clinicHtml = `
    <a href="clinics/${this.id}" data-id="${this.id}" class="show_link"><h3>${this.name}</h3></a>
    `
    return clinicHtml;
}

//Prototype function (similar to instance methods) to format a individual clinic
Clinic.prototype.formatShow = function() {
    //Template strings to advoid strings concatenation
    let clinicHtml = `
    <h3>${this.name}</h3>
    <h3>${this.state}</h3>
    `
    return clinicHtml;
}

//Prototype function (similar to instance methods) to format a individual appointment
Appointment.prototype.formatAppointment = function() {
    //Template strings to advoid strings concatenation
    let appointmentHtml = `
    <h3>${this.date}</h3>
    <h3>${this.time}</h3>
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

//Clear html to repaint the DOM
const clearDom = () => {
    $('#app-container').html('');
}