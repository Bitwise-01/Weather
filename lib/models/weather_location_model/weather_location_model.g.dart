// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLocationModel _$WeatherLocationModelFromJson(
        Map<String, dynamic> json) =>
    WeatherLocationModel(
      weather: WeatherModel.fromJson(json['weather'] as Map<String, dynamic>),
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherLocationModelToJson(
        WeatherLocationModel instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'location': instance.location,
    };
