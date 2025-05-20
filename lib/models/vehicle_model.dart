// models/vehicle_model.dart
class Vehicle {
  final String id;
  final String make;
  final String model;
  final String year;
  final String licensePlate;
  final String userId;
  final int mileage; // New field for mileage

  Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.userId,
    required this.mileage, // Add mileage parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'licensePlate': licensePlate,
      'userId': userId,
      'mileage': mileage, // Include mileage in map
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map, String id) {
    return Vehicle(
      id: id,
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? '',
      licensePlate: map['licensePlate'] ?? '',
      userId: map['userId'] ?? '',
      mileage: map['mileage'] ?? 0, // Parse mileage from map
    );
  }
}
