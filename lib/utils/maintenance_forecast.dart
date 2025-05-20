// utils/maintenance_forecast.dart
import '../models/vehicle_model.dart';

class MaintenanceForecast {
  static const int OIL_CHANGE_INTERVAL = 5000; // Every 5000 km
  static const int TIRE_ROTATION_INTERVAL = 10000; // Every 10000 km
  static const int BRAKE_CHECK_INTERVAL = 15000; // Every 15000 km
  static const int MAJOR_SERVICE_INTERVAL = 30000; // Every 30000 km

  static List<Map<String, dynamic>> getUpcomingMaintenance(List<Vehicle> vehicles) {
    final List<Map<String, dynamic>> maintenanceItems = [];

    for (final vehicle in vehicles) {
      // Calculate next oil change
      final nextOilChange = (vehicle.mileage ~/ OIL_CHANGE_INTERVAL + 1) * OIL_CHANGE_INTERVAL;
      final kmUntilOilChange = nextOilChange - vehicle.mileage;
      if (kmUntilOilChange <= 1000) {
        maintenanceItems.add({
          'vehicle': '${vehicle.make} ${vehicle.model}',
          'maintenance': 'Oil Change',
          'dueIn': kmUntilOilChange,
        });
      }

      // Calculate next tire rotation
      final nextTireRotation = (vehicle.mileage ~/ TIRE_ROTATION_INTERVAL + 1) * TIRE_ROTATION_INTERVAL;
      final kmUntilTireRotation = nextTireRotation - vehicle.mileage;
      if (kmUntilTireRotation <= 1000) {
        maintenanceItems.add({
          'vehicle': '${vehicle.make} ${vehicle.model}',
          'maintenance': 'Tire Rotation',
          'dueIn': kmUntilTireRotation,
        });
      }

      // Calculate next brake check
      final nextBrakeCheck = (vehicle.mileage ~/ BRAKE_CHECK_INTERVAL + 1) * BRAKE_CHECK_INTERVAL;
      final kmUntilBrakeCheck = nextBrakeCheck - vehicle.mileage;
      if (kmUntilBrakeCheck <= 1500) {
        maintenanceItems.add({
          'vehicle': '${vehicle.make} ${vehicle.model}',
          'maintenance': 'Brake Check',
          'dueIn': kmUntilBrakeCheck,
        });
      }

      // Calculate next major service
      final nextMajorService = (vehicle.mileage ~/ MAJOR_SERVICE_INTERVAL + 1) * MAJOR_SERVICE_INTERVAL;
      final kmUntilMajorService = nextMajorService - vehicle.mileage;
      if (kmUntilMajorService <= 2000) {
        maintenanceItems.add({
          'vehicle': '${vehicle.make} ${vehicle.model}',
          'maintenance': 'Major Service',
          'dueIn': kmUntilMajorService,
        });
      }
    }

    // Sort by urgency (lowest km first)
    maintenanceItems.sort((a, b) => a['dueIn'].compareTo(b['dueIn']));

    return maintenanceItems;
  }
}
