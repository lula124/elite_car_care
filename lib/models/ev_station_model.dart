// models/ev_station_model.dart
class EVStation {
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> connectorTypes;
  final bool isAvailable;

  EVStation({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.connectorTypes,
    required this.isAvailable,
  });

  factory EVStation.fromMap(Map<String, dynamic> map, String id) {
    return EVStation(
      id: id,
      name: map['name'],
      address: map['address'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      connectorTypes: List<String>.from(map['connectorTypes']),
      isAvailable: map['isAvailable'],
    );
  }
}
