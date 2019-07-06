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
        //Whenever we use fetch, we get back a promise that will be resolved or rejected. Since we wrote the backend API, it will be resolved.
        fetch(`/clinics.json`)
            .then(res => res.json())
            .then(data => console.log(data))
    });
};