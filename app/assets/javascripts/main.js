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

    $('#new_appointment').on("submit", (e) => {
        e.preventDefault();
        console.log('submitting apptttttttttttttttt')
    })
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

//Prototype function (similar to instance methods) to format a individual clinic
Clinic.prototype.formatShow = function() {
    //Template strings to advoid strings concatenation
    let clinicHtml = `
    <h3>${this.name}</h3>
    <h3>${this.state}</h3>
    `
    return clinicHtml;
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