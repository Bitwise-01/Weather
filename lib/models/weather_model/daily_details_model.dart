import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/utils/helpers.dart';

part 'daily_details_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyDetailsModel extends Equatable {
  final String time;
  final double temperature_2mMin;
  final double temperature_2mMax;
  final double precipitationSum;
  final int weatherCode;

  const DailyDetailsModel({
    required this.time,
    required this.temperature_2mMin,
    required this.temperature_2mMax,
    required this.precipitationSum,
    required this.weatherCode,
  });

  factory DailyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DailyDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$DailyDetailsModelToJson(this);

  String get weatherDescription =>
      WeatherCodeDescription.getDescription(weatherCode);

  IconData get weatherIcon => WeatherCodeIcon().getIcon(weatherCode);

  String get date => DateFormat('EEE', 'en_US').format(DateTime.parse(time));

  @override
  List<Object> get props => [
        time,
        temperature_2mMin,
        temperature_2mMax,
        precipitationSum,
        weatherCode,
      ];

  @override
  String toString() {
    return 'DailyDetailsModel{time: $time, temperatureMin: $temperature_2mMin, '
        'temperatureMax: $temperature_2mMax, precipitationSum: $precipitationSum, '
        'weatherCode: $weatherCode, description: $weatherDescription}';
  }
}
