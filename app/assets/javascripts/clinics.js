//Document ready function to hijack the click event on the See All Clinics link on the donor's show page
$(() => {
    listenForClick();
});

const listenForClick = () => {
    $('.all_clinics').on('click', (e) => {
        e.preventDefault();
        console.log('tessssssssssst');
    });
}