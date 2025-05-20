// services/maintenance_service.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/maintenance_record_model.dart';

class MaintenanceService {
  final DatabaseReference _maintenanceRef = FirebaseDatabase.instance.ref('maintenance_records');

  Future<String> addMaintenanceRecord({
    required String vehicleId,
    required String type,
    required int mileage,
    required String date,
    required String notes,
  }) async {
    final newRecordRef = _maintenanceRef.push();
    final record = MaintenanceRecord(
      id: newRecordRef.key ?? '',
      vehicleId: vehicleId,
      type: type,
      mileage: mileage,
      date: date,
      notes: notes,
    );
    await newRecordRef.set(record.toMap());
    return newRecordRef.key ?? '';
  }

  Stream<List<MaintenanceRecord>> getMaintenanceRecords(String vehicleId) {
    return _maintenanceRef.orderByChild('vehicleId').equalTo(vehicleId).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];
      return data.entries.map((entry) {
        return MaintenanceRecord.fromMap(Map<String, dynamic>.from(entry.value), entry.key);
      }).toList();
    });
  }

  Future<void> deleteMaintenanceRecord(String id) async {
    await _maintenanceRef.child(id).remove();
  }
}
