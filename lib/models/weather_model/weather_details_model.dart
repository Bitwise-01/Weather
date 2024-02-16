import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/utils/helpers.dart';

part 'weather_details_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherDetailsModel extends Equatable {
  final String time;
  final double temperature_2m;
  final int relativeHumidity_2m;
  final double precipitation;
  final double windSpeed_10m;
  final int weatherCode;

  const WeatherDetailsModel({
    required this.time,
    required this.temperature_2m,
    required this.relativeHumidity_2m,
    required this.precipitation,
    required this.windSpeed_10m,
    required this.weatherCode,
  });

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDetailsModelToJson(this);

  String get weatherDescription =>
      WeatherCodeDescription.getDescription(weatherCode);

  IconData get weatherIcon => WeatherCodeIcon(time: time).getIcon(weatherCode);

  String get singleHour => DateFormat("ha").format(DateTime.parse(time));

  @override
  List<Object> get props => [
        time,
        temperature_2m,
        relativeHumidity_2m,
        precipitation,
        windSpeed_10m,
        weatherCode,
      ];

  @override
  String toString() {
    return 'WeatherDetails{time: $time, temperature: $temperature_2m, '
        'humidity: $relativeHumidity_2m%, precipitation: $precipitation, '
        'windSpeed: $windSpeed_10m, weatherCode: $weatherCode, '
        'description: $weatherDescription}';
  }
}
