import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/location_model/location_object.dart';

class LocationService {
  static LocationObject? _locationObject; // Stores location data once fetched

  // Initializes the service by attempting to get the current location
  static Future<bool> init() async {
    await getCurrentLocation();
    return _locationObject != null; // Returns true if location was found
  }

  // Returns the current location (after initialization, if needed)
  static Future<LocationObject?> get currentLocation async {
    if (_locationObject != null) {
      return _locationObject; // Return cached location if available
    }
    await init(); // Try to initialize if not done yet
    return _locationObject;
  }

  // Core function to determine location and address information
  static Future<LocationObject> getCurrentLocation() async {
    // 1. Check Location Services
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // 2. Check Location Permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 3. Get Device Position (if permissions are granted)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );

    // 4. Convert Coordinates to Address
    _locationObject =
        await coordinatesToLocation(position.latitude, position.longitude);
    return _locationObject!;
  }

  // Helper function to get address details from latitude and longitude
  static Future<LocationObject> coordinatesToLocation(
      double lat, double lon) async {
    List<Placemark> places = await placemarkFromCoordinates(lat, lon);
    if (places.isEmpty) {
      Future.error("Location failed");
    }

    // Construct the LocationObject using relevant placemark data
    return LocationObject(
      country: places.first.country ?? "",
      region: places.first.administrativeArea ?? "",
      city: places.first.locality ?? "",
      lat: lat.toString(),
      lon: lon.toString(),
    );
  }
}
