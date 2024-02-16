import 'package:equatable/equatable.dart';
import 'package:weather/cubits/base_cubit.dart';
import 'package:weather/models/location_model/location_model.dart';
import 'package:weather/models/weather_location_model/weather_location_model.dart';
import 'package:weather/services/api_service/api_service.dart';

part 'weather_state.dart';

class WeatherCubit extends BaseCubit<WeatherState> {
  final ApiService _weatherService;
  Map<String, WeatherLocationModel> citiesWeather = {};
  Map<String, DateTime> citiesWeatherTime = {};

  WeatherCubit(this._weatherService) : super(WeatherInitial());

  Future<void> fetchWeather(LocationModel location) async {
    String latitude = location.lat!;
    String longitude = location.lon!;

    final weatherKey = "$latitude,$longitude";

    // Check cache
    if (citiesWeather.containsKey(weatherKey)) {
      DateTime now = DateTime.now();
      DateTime cachedTime = citiesWeatherTime[weatherKey]!;

      // Check if the cached data is older than 5 minutes
      if (now.difference(cachedTime).inMinutes <= 5) {
        // If the cached data is less than 5 minutes old, emit it
        emit(WeatherLoaded(citiesWeather[weatherKey]!));
        return;
      }

      // If it's more than 5 minutes old, remove from cache
      citiesWeather.remove(weatherKey);
      citiesWeatherTime.remove(weatherKey);
    }

    try {
      emit(WeatherLoading());
      final weatherResponse = await _weatherService.fetchWeather(
          latitude: latitude, longitude: longitude);

      WeatherLocationModel weatherLocation =
          WeatherLocationModel(weather: weatherResponse, location: location);

      citiesWeather[weatherKey] = weatherLocation;
      citiesWeatherTime[weatherKey] = DateTime.now();

      emit(WeatherLoaded(weatherLocation));
    } catch (e) {
      emit(WeatherError("Failed to fetch weather data: $e"));
    }
  }

  @override
  Future<void> reset() async {
    citiesWeather.clear();
    citiesWeatherTime.clear();
    emit(WeatherInitial());
  }
}
