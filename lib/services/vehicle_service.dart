// services/vehicle_service.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/vehicle_model.dart';

class VehicleService {
  final DatabaseReference _vehiclesRef = FirebaseDatabase.instance.ref('vehicles');

  // Add a new vehicle
  Future<String> addVehicle(Vehicle vehicle) async {
    try {
      final newVehicleRef = _vehiclesRef.push();
      await newVehicleRef.set(vehicle.toMap());
      return newVehicleRef.key ?? '';
    } catch (e) {
      rethrow;
    }
  }

  // Get all vehicles for a specific user
  Stream<List<Vehicle>> getUserVehicles(String userId) {
    return _vehiclesRef
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) {
      final Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
      if (data == null) return [];

      return data.entries.map((entry) {
        return Vehicle.fromMap(
          Map<String, dynamic>.from(entry.value as Map),
          entry.key,
        );
      }).toList();
    });
  }

  Future
  <void> updateVehicleMileage(String vehicleId, int newMileage) async {
    try {
      await _vehiclesRef.child(vehicleId).update({'mileage': newMileage});
    } catch (e) {
      rethrow;
    }
  }
  // Update a vehicle
  Future<void> updateVehicle(Vehicle vehicle) async {
    try {
      await _vehiclesRef.child(vehicle.id).update(vehicle.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await _vehiclesRef.child(vehicleId).remove();
    } catch (e) {
      rethrow;
    }
  }
}
