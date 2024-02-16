import 'package:shared_preferences/shared_preferences.dart';

// Defines the possible measurement systems
enum MeasureSystem { metric, imperial }

// Adds properties to the MeasureSystem enum for convenient access to units
extension MeasureSystemExten on MeasureSystem {
  // Returns the appropriate speed unit based on the measurement system
  String get speed {
    switch (this) {
      case MeasureSystem.metric:
        return "kmh";
      case MeasureSystem.imperial:
        return "mph";
    }
  }

  // Returns the appropriate temperature unit based on the measurement system
  String get temp {
    switch (this) {
      case MeasureSystem.metric:
        return "Celsius";
      case MeasureSystem.imperial:
        return "Fahrenheit";
    }
  }

  // Returns a user-friendly name for the measurement system
  String get name {
    switch (this) {
      case MeasureSystem.metric:
        return "Metric";
      case MeasureSystem.imperial:
        return "Imperial";
    }
  }
}

// Service class to manage saving and loading the preferred measurement system
class PreferencesService {
  // Stores the preferred measurement system in SharedPreferences
  Future<void> saveMeasurementSystem(MeasureSystem system) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('measurementSystem', system.name);
  }

  // Retrieves the preferred measurement system from SharedPreferences, with a US-based default
  Future<MeasureSystem> getMeasurementSystem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? systemName = prefs.getString('measurementSystem');

    // Return the stored system if found, otherwise default to Imperial
    if (systemName != null) {
      return MeasureSystem.values.firstWhere(
        (s) => s.name == systemName,
        orElse: () => MeasureSystem.imperial,
      );
    }
    return MeasureSystem.imperial;
  }
}
