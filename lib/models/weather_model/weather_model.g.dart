// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String,
      elevation: (json['elevation'] as num).toDouble(),
      hourly: ForecastModel.fromJson(json['hourly'] as Map<String, dynamic>),
      daily: DailyModel.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timezone': instance.timezone,
      'elevation': instance.elevation,
      'hourly': instance.hourly.toJson(),
      'daily': instance.daily.toJson(),
    };
