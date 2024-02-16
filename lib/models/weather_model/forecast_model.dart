import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/weather_model/weather_details_model.dart';

part 'forecast_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ForecastModel extends Equatable {
  final List<String> time;
  final List<double> temperature_2m;
  final List<int> relativeHumidity_2m;
  final List<double> precipitation;
  final List<double> windSpeed_10m;
  final List<int> weatherCode;

  const ForecastModel({
    required this.time,
    required this.temperature_2m,
    required this.relativeHumidity_2m,
    required this.precipitation,
    required this.windSpeed_10m,
    required this.weatherCode,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);

  // Method to search for the index of the time and retrieve related data
  WeatherDetailsModel? getWeatherDetailsByTime(String searchTime) {
    int index = time.indexOf(searchTime);

    index = index != -1 ? index : 0;

    return index != -1
        ? WeatherDetailsModel(
            time: time[index],
            temperature_2m: temperature_2m[index],
            relativeHumidity_2m: relativeHumidity_2m[index],
            precipitation: precipitation[index],
            windSpeed_10m: windSpeed_10m[index],
            weatherCode: weatherCode[index])
        : null;
  }

  WeatherDetailsModel? getWeatherDetailsByIndex(int index) {
    if (index < 0 || index > time.length) {
      return null;
    }

    return WeatherDetailsModel(
        time: time[index],
        temperature_2m: temperature_2m[index],
        relativeHumidity_2m: relativeHumidity_2m[index],
        precipitation: precipitation[index],
        windSpeed_10m: windSpeed_10m[index],
        weatherCode: weatherCode[index]);
  }

  @override
  List<Object> get props => [
        time,
        temperature_2m,
        relativeHumidity_2m,
        precipitation,
        windSpeed_10m,
        weatherCode,
      ];
}
