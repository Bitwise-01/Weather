import 'dart:convert'; // For JSON handling
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model/weather_model.dart';

class ApiService {
  // Fetches weather data from the Open-Meteo API
  Future<WeatherModel> fetchWeather(
      {required String latitude,
      required String longitude,
      http.Client? client}) async {
    // 1. Construct API URL
    final url = Uri.parse(getURL(latitude: latitude, longitude: longitude));

    // 2.  Make HTTP Request
    final response = await (client != null ? client.get(url) : http.get(url));

    // 3.  Handle Response
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return WeatherModel.fromJson(
          responseJson); // Parse JSON into WeatherModel
    } else {
      throw Exception('Failed to load weather data'); // Handle errors
    }
  }

  static String getURL({required String latitude, required String longitude}) {
    return 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch';
  }
}
