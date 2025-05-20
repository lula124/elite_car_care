// services/ev_station_service.dart
import 'package:firebase_database/firebase_database.dart';
import '../models/ev_station_model.dart';

class EVStationService {
  final DatabaseReference _stationsRef = FirebaseDatabase.instance.ref('ev_stations');

  Stream<List<EVStation>> getEVStations() {
    return _stationsRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return [];
      return data.entries.map((entry) {
        return EVStation.fromMap(Map<String, dynamic>.from(entry.value), entry.key);
      }).toList();
    });
  }
}
