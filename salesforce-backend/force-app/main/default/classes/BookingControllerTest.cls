@isTest
public class BookingControllerTest {

    @isTest
    static void testCreateAndGetBookings() {

        Test.startTest();

        // Create Booking
        String result = BookingController.createBooking(
            'Test User',
            'test@email.com',
            '9876543210',
            Date.today(),
            100
        );

        System.assertEquals('Success', result);

        // Fetch Bookings
        List<Booking__c> bookings = BookingController.getBookings();
        System.assert(bookings.size() > 0);

        Test.stopTest();
    }

    @isTest
    static void testUpdateBooking() {

        Booking__c booking = new Booking__c(
            Name = 'Update Test',
            Status__c = 'Pending'
        );
        insert booking;

        Test.startTest();

        String result = BookingController.updateBooking(booking.Id, 'Confirmed');

        Test.stopTest();

        System.assertEquals('Updated', result);
    }

    @isTest
    static void testDeleteBooking() {

        Booking__c booking = new Booking__c(Name = 'Delete Test');
        insert booking;

        Test.startTest();

        String result = BookingController.deleteBooking(booking.Id);

        Test.stopTest();

        System.assertEquals('Deleted', result);
    }
}
