import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_object.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationObject extends Equatable {
  final String country;
  final String region;
  final String city;
  final String lat;
  final String lon;

  const LocationObject({
    required this.country,
    required this.region,
    required this.city,
    required this.lat,
    required this.lon,
  });

  factory LocationObject.fromJson(Map<String, dynamic> json) =>
      _$LocationObjectFromJson(json);

  Map<String, dynamic> toJson() => _$LocationObjectToJson(this);

  @override
  String toString() => 'LocationObject{ country: $country, '
      'region: $region, '
      'city: $city, '
      'lat: $lat, '
      'lon: $lon '
      '}';

  @override
  List<Object?> get props => [country, region, city, lat, lon];
}
