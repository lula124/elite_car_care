// services/booking_service.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/service_booking_model.dart';
import '../models/service_station_model.dart';

class BookingService {
  final DatabaseReference _bookingsRef = FirebaseDatabase.instance.ref('bookings');
  final DatabaseReference _stationsRef = FirebaseDatabase.instance.ref('service_stations');

  // Get all service stations
  Stream<List<ServiceStation>> getServiceStations() {
    return _stationsRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];

      return data.entries.map((entry) {
        return ServiceStation.fromMap(
          Map<String, dynamic>.from(entry.value as Map),
          entry.key,
        );
      }).toList();
    });
  }

  // Get available time slots for a specific date and service station
  Future<List<String>> getAvailableTimeSlots(String stationId, DateTime date) async {
    final dateString = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    // Get all slots for this day from the service station
    final stationSnapshot = await _stationsRef.child(stationId).get();
    if (!stationSnapshot.exists) return [];

    final stationData = Map<String, dynamic>.from(stationSnapshot.value as Map);
    final station = ServiceStation.fromMap(stationData, stationId);

    // Get all slots for this day
    final allSlots = station.availableSlots[dateString] ?? [];

    // Get booked slots for this day and station
    final bookedSnapshot = await _bookingsRef
        .orderByChild('serviceStationId')
        .equalTo(stationId)
        .get();

    if (!bookedSnapshot.exists) return allSlots;

    final bookedData = Map<dynamic, dynamic>.from(bookedSnapshot.value as Map);
    final bookedSlots = bookedData.entries
        .map((e) => ServiceBooking.fromMap(Map<String, dynamic>.from(e.value as Map), e.key))
        .where((booking) =>
    booking.bookingDate.year == date.year &&
        booking.bookingDate.month == date.month &&
        booking.bookingDate.day == date.day)
        .map((booking) => booking.timeSlot)
        .toList();

    // Return available slots (all slots minus booked slots)
    return allSlots.where((slot) => !bookedSlots.contains(slot)).toList();
  }

  // Create a new booking
  Future<String> createBooking(ServiceBooking booking) async {
    try {
      final newBookingRef = _bookingsRef.push();
      await newBookingRef.set(booking.toMap());
      return newBookingRef.key ?? '';
    } catch (e) {
      rethrow;
    }
  }

  // Get user's bookings
  Stream<List<ServiceBooking>> getUserBookings(String userId) {
    return _bookingsRef
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];

      return data.entries.map((entry) {
        return ServiceBooking.fromMap(
          Map<String, dynamic>.from(entry.value as Map),
          entry.key,
        );
      }).toList();
    });
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _bookingsRef.child(bookingId).remove();
    } catch (e) {
      rethrow;
    }
  }
}
