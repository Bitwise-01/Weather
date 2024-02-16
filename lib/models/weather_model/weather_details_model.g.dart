// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDetailsModel _$WeatherDetailsModelFromJson(Map<String, dynamic> json) =>
    WeatherDetailsModel(
      time: json['time'] as String,
      temperature_2m: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity_2m: json['relative_humidity_2m'] as int,
      precipitation: (json['precipitation'] as num).toDouble(),
      windSpeed_10m: (json['wind_speed_10m'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
    );

Map<String, dynamic> _$WeatherDetailsModelToJson(
        WeatherDetailsModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature_2m,
      'relative_humidity_2m': instance.relativeHumidity_2m,
      'precipitation': instance.precipitation,
      'wind_speed_10m': instance.windSpeed_10m,
      'weather_code': instance.weatherCode,
    };
