// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationObject _$LocationObjectFromJson(Map<String, dynamic> json) =>
    LocationObject(
      country: json['country'] as String,
      region: json['region'] as String,
      city: json['city'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
    );

Map<String, dynamic> _$LocationObjectToJson(LocationObject instance) =>
    <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'lat': instance.lat,
      'lon': instance.lon,
    };
