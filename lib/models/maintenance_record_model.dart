// models/maintenance_record_model.dart
class MaintenanceRecord {
  final String id;
  final String vehicleId;
  final String type; // Maintenance, Repair, Service
  final int mileage;
  final String date;
  final String notes;

  MaintenanceRecord({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.mileage,
    required this.date,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'type': type,
      'mileage': mileage,
      'date': date,
      'notes': notes,
    };
  }

  factory MaintenanceRecord.fromMap(Map<String, dynamic> map, String id) {
    return MaintenanceRecord(
      id: id,
      vehicleId: map['vehicleId'] ?? '',
      type: map['type'] ?? '',
      mileage: map['mileage'] ?? 0,
      date: map['date'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
