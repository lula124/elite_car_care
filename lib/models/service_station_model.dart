// models/service_station_model.dart
class ServiceStation {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String? email; // Add email field as nullable
  final String? otherInfo; // Add otherInfo field as nullable
  final List<String> services;
  final Map<String, List<String>> availableSlots;

  ServiceStation({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.email, // Make it optional
    this.otherInfo, // Make it optional
    required this.services,
    required this.availableSlots,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'otherInfo': otherInfo,
      'services': services,
      'availableSlots': availableSlots,
    };
  }

  factory ServiceStation.fromMap(Map<String, dynamic> map, String id) {
    return ServiceStation(
      id: id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'], // Parse email from map
      otherInfo: map['otherInfo'], // Parse otherInfo from map
      services: List<String>.from(map['services'] ?? []),
      availableSlots: Map<String, List<String>>.from(
        (map['availableSlots'] ?? {}).map(
              (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
    );
  }
}
