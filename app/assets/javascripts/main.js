//Document ready function to hijack the click event on the See All Clinics link on the donor's show page
//Arrow function!
$(() => {
    listenForClick();
});

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
        //Whenever we use fetch (native API to the browser called on the global object), we get back a promise that will be resolved or rejected. 
        //Since we wrote the backend API, it will be resolved.
        fetch(`/clinics.json`)
            //Use #then to get the response object and call #json to convert it and extract/parse the data that we want
            .then(response => response.json())
            //Return the data we got in a following then method. Call it clinics, to be semantic
            .then(clinics => {
                //Clear html to repaint the DOM
                $('#app-container').html('')
                //Iterate over all the clinics
                clinics.forEach(clinic => {
                    //Use constructor function to create clinic objects
                    let newClinic = new Clinic(clinic);
                    let clinicContent = newClinic.formatIndex();
                    $('#app-container').append(clinicContent);
                })
            })
    });
    
    $(document).on('click', '.show_link', function(e) {
        e.preventDefault();
        // console.log($(this).attr('data-id'))
        let id = $(this).attr('data-id')
        fetch(`clinics/${id}.json`)
            .then(response => response.json())
        //     //Return the data we got in a following then method. Call it clinics, to be semantic
            .then(clinic => {
             console.log(clinic)
            })
    });
};

//Constructor function (use response we get from server and use a JS Model Object)
//Could have used a ES6 class
function Clinic(clinic) {
    this.id = clinic.id;
    this.name = clinic.name;
    this.state = clinic.state;
}

//Prototype function (similar to instance methods) to format our clinics
Clinic.prototype.formatIndex = function() {
    //Template strings to advoid strings concatenation
    let clinicHtml = `
    <a href="clinics/${this.id}" data-id="${this.id}" class="show_link"><h3>${this.name}</h3></a>
    `
    return clinicHtml;
}

// $(() => {
//     listenForClick();
// });

// const listenForClick = () => {
//     $('.all_appointments').on('click', (e) => {
//         e.preventDefault();
//         console.log('hellooooooooooo')
//         // history.pushState(null, null, "appointments");
//         console.log(fetch(`/appointments.json`))
//         //     .then(response => response.json())
//         //     .then(appointments => {
//         //         $('#app-container').html('')
//         //         appointments.forEach(appointment => {
//         //              let newAppointment = new Appointment(appointment);
//         //              let appointmentContent = newAppointment.formatIndex();
//         //             $('#app-container').append(appointmentContent);
//         //         })
//         //     })
//     });
// };

// // function Appointment(appointment) {
// //     this.id = appointment.id;
// //     this.date = appointment.date;
// // }

// // Appointment.prototype.formatIndex = function() {
// //     let appointmentHtml = `
// //     <a href="appointments/${this.id}"><h3>${this.date}</h3></a>
// //     `
// //     return appointmentHtml;
// // }