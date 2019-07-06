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
        //Whenever we use fetch (native API to the browser called on the global object), we get back a promise that will be resolved or rejected. 
        //Since we wrote the backend API, it will be resolved.
        fetch(`/clinics.json`)
            //Use #then to get the response object and call #json to convert it and extract/parse the data that we want
            .then(response => response.json())
            //Return the data we got in a following then method. Call it clinics, to be semantic
            .then(clinics => {
                //Clear html to repaint the DOM
                $('#app-container').html('')
                clinics.forEach(clinic => {
                    console.log(clinic);
                })
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