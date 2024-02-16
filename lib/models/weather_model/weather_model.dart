import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/weather_model/daily_details_model.dart';
import 'package:weather/models/weather_model/daily_model.dart';
import 'package:weather/models/weather_model/forecast_model.dart';
import 'package:weather/models/weather_model/weather_details_model.dart';
import 'package:weather/utils/helpers.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel extends Equatable {
  final double latitude;
  final double longitude;
  final String timezone;
  final double elevation;
  final ForecastModel hourly;
  final DailyModel daily;

  const WeatherModel(
      {required this.latitude,
      required this.longitude,
      required this.timezone,
      required this.elevation,
      required this.hourly,
      required this.daily});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherDetailsModel? getWeatherDetailsByIndex(int index) =>
      hourly.getWeatherDetailsByIndex(index);

  WeatherDetailsModel? getWeatherGivenTime(String searchTime) =>
      hourly.getWeatherDetailsByTime(searchTime);

  WeatherDetailsModel? get getWeatherCurrentHour =>
      hourly.getWeatherDetailsByTime(getCurrentTime());

  DailyDetailsModel? getDailyDetailsGivenDate(String searchDate) =>
      daily.getDailyDetailsByDate(searchDate);

  DailyDetailsModel? getDailyDetailsByIndex(int index) =>
      daily.getDailyDetailsByIndex(index);

  @override
  List<Object> get props => [latitude, longitude, timezone, elevation, hourly];
}
