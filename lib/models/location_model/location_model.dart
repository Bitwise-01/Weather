import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel extends Equatable {
  final String? id;
  final String? country;
  final String? region;
  final String? city;
  final String? lat;
  final String? lon;

  const LocationModel({
    this.id,
    this.country,
    this.region,
    this.city,
    required this.lat,
    required this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  @override
  String toString() => 'LocationModel{ id: $id, '
      'country: $country, '
      'region: $region, '
      'city: $city, '
      'lat: $lat, '
      'lon: $lon '
      '}';

  @override
  List<Object?> get props => [
        id,
        country,
        region,
        city,
        lat,
        lon,
      ];
}
