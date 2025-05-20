// models/service_booking_model.dart
class ServiceBooking {
  final String id;
  final String userId;
  final String vehicleId;
  final String serviceType; // 'Service', 'Repair', 'Other'
  final DateTime bookingDate;
  final String timeSlot;
  final String serviceStationId;
  final String serviceStationName;
  final bool isConfirmed;

  ServiceBooking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.serviceType,
    required this.bookingDate,
    required this.timeSlot,
    required this.serviceStationId,
    required this.serviceStationName,
    this.isConfirmed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vehicleId': vehicleId,
      'serviceType': serviceType,
      'bookingDate': bookingDate.toIso8601String(),
      'timeSlot': timeSlot,
      'serviceStationId': serviceStationId,
      'serviceStationName': serviceStationName,
      'isConfirmed': isConfirmed,
    };
  }

  factory ServiceBooking.fromMap(Map<String, dynamic> map, String id) {
    return ServiceBooking(
      id: id,
      userId: map['userId'] ?? '',
      vehicleId: map['vehicleId'] ?? '',
      serviceType: map['serviceType'] ?? '',
      bookingDate: DateTime.parse(map['bookingDate']),
      timeSlot: map['timeSlot'] ?? '',
      serviceStationId: map['serviceStationId'] ?? '',
      serviceStationName: map['serviceStationName'] ?? '',
      isConfirmed: map['isConfirmed'] ?? false,
    );
  }
}
