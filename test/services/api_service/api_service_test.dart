import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model/daily_model.dart';
import 'package:weather/models/weather_model/forecast_model.dart';
import 'package:weather/models/weather_model/weather_model.dart';
import 'package:weather/services/api_service/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const double lat = 1.2;
  const double lon = 2.1;

  group('fetchWeather', () {
    test('returns WeatherModel on successful HTTP call', () async {
      final mockClient = MockClient();
      final apiService = ApiService();

      when(mockClient.get(
              Uri.parse(ApiService.getURL(
                  latitude: lat.toString(), longitude: lon.toString())),
              headers: anyNamed('headers')))
          .thenAnswer(
        (_) async => http.Response(
            jsonEncode(const WeatherModel(
              latitude: lat,
              longitude: lon,
              timezone: "America/New_York",
              elevation: 10.0,
              hourly: ForecastModel(
                  time: ["2021-09-09T00:00"],
                  temperature_2m: [20.0],
                  relativeHumidity_2m: [30],
                  precipitation: [0.0],
                  windSpeed_10m: [5.0],
                  weatherCode: [2]),
              daily: DailyModel(
                  time: ["2021-09-09"],
                  temperature_2mMin: [15.0],
                  temperature_2mMax: [25.0],
                  precipitationSum: [0.0],
                  weatherCode: [2]),
            ).toJson()),
            200),
      );

      // Execute the function under test
      final result = await apiService.fetchWeather(
          latitude: lat.toString(),
          longitude: lon.toString(),
          client: mockClient);

      // Validate the result is a WeatherModel
      expect(result, isA<WeatherModel>());
      expect(result.latitude, lat);
      expect(result.longitude, lon);
      expect(result.timezone, 'America/New_York');
      expect(result.elevation, 10.0);
      expect(result.hourly.time.isNotEmpty, true);
      expect(result.daily.time.isNotEmpty, true);
    });

    // Mock failure response
    test('throws Exception on failed HTTP call', () {
      final client = MockClient();
      when(client.get(Uri.parse(ApiService.getURL(
              latitude: lat.toString(), longitude: lon.toString()))))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final apiService = ApiService();
      expect(
          apiService.fetchWeather(
              latitude: lat.toString(),
              longitude: lon.toString(),
              client: client),
          throwsException);
    });
  });

  group("getURL", () {
    test("Successfully returns url", () {
      const url =
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch';

      expect(
          ApiService.getURL(
              latitude: lat.toString(), longitude: lon.toString()),
          url);
    });
  });
}
