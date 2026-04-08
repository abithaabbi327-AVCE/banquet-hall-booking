import { LightningElement, track } from 'lwc';
import createBooking from '@salesforce/apex/BookingController.createBooking';
import getBookings from '@salesforce/apex/BookingController.getBookings';

export default class BanquetBooking extends LightningElement {

    @track name = '';
    @track email = '';
    @track phone = '';
    @track eventDate = '';
    @track guests = '';
    @track bookings = [];

    connectedCallback() {
        this.loadBookings();
    }

    handleChange(event) {
        const field = event.target.dataset.field;
        this[field] = event.target.value;
    }

    handleSubmit() {
        createBooking({
            name: this.name,
            email: this.email,
            phone: this.phone,
            eventDate: this.eventDate,
            guests: this.guests
        })
        .then(() => {
            alert('Booking Created');
            this.loadBookings();
        })
        .catch(error => {
            console.error(error);
        });
    }

    loadBookings() {
        getBookings()
            .then(result => {
                this.bookings = result;
            })
            .catch(error => {
                console.error(error);
            });
    }
}
