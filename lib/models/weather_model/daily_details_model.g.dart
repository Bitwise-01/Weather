// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDetailsModel _$DailyDetailsModelFromJson(Map<String, dynamic> json) =>
    DailyDetailsModel(
      time: json['time'] as String,
      temperature_2mMin: (json['temperature_2m_min'] as num).toDouble(),
      temperature_2mMax: (json['temperature_2m_max'] as num).toDouble(),
      precipitationSum: (json['precipitation_sum'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
    );

Map<String, dynamic> _$DailyDetailsModelToJson(DailyDetailsModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m_min': instance.temperature_2mMin,
      'temperature_2m_max': instance.temperature_2mMax,
      'precipitation_sum': instance.precipitationSum,
      'weather_code': instance.weatherCode,
    };
