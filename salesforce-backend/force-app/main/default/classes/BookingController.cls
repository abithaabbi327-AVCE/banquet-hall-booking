public with sharing class BookingController {

    // Create Booking
    @AuraEnabled
    public static String createBooking(String name, String email, String phone, Date eventDate, Integer guests) {
        try {
            Booking__c booking = new Booking__c(
                Name = name,
                Email__c = email,
                Phone__c = phone,
                Event_Date__c = eventDate,
                Guests__c = guests,
                Status__c = 'Pending'
            );
            insert booking;
            return 'Success';
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    // Get All Bookings
    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getBookings() {
        return [
            SELECT Id, Name, Email__c, Phone__c, Event_Date__c, Guests__c, Status__c
            FROM Booking__c
            ORDER BY CreatedDate DESC
        ];
    }

    // Update Booking
    @AuraEnabled
    public static String updateBooking(Id bookingId, String status) {
        try {
            Booking__c booking = [SELECT Id, Status__c FROM Booking__c WHERE Id = :bookingId LIMIT 1];
            booking.Status__c = status;
            update booking;
            return 'Updated';
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    // Delete Booking
    @AuraEnabled
    public static String deleteBooking(Id bookingId) {
        try {
            Booking__c booking = [SELECT Id FROM Booking__c WHERE Id = :bookingId LIMIT 1];
            delete booking;
            return 'Deleted';
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}
