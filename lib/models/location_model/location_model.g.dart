// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: json['id'] as String?,
      country: json['country'] as String?,
      region: json['region'] as String?,
      city: json['city'] as String?,
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'lat': instance.lat,
      'lon': instance.lon,
    };
