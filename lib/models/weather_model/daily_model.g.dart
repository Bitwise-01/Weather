// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyModel _$DailyModelFromJson(Map<String, dynamic> json) => DailyModel(
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      temperature_2mMin: (json['temperature_2m_min'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      temperature_2mMax: (json['temperature_2m_max'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      precipitationSum: (json['precipitation_sum'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      weatherCode:
          (json['weather_code'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DailyModelToJson(DailyModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m_min': instance.temperature_2mMin,
      'temperature_2m_max': instance.temperature_2mMax,
      'precipitation_sum': instance.precipitationSum,
      'weather_code': instance.weatherCode,
    };
