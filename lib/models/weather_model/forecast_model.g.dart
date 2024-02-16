// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      temperature_2m: (json['temperature_2m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      relativeHumidity_2m: (json['relative_humidity_2m'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      precipitation: (json['precipitation'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      windSpeed_10m: (json['wind_speed_10m'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weatherCode:
          (json['weather_code'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature_2m,
      'relative_humidity_2m': instance.relativeHumidity_2m,
      'precipitation': instance.precipitation,
      'wind_speed_10m': instance.windSpeed_10m,
      'weather_code': instance.weatherCode,
    };
