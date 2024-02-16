import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/location_model/location_model.dart';
import 'package:weather/models/weather_model/weather_model.dart';

part 'weather_location_model.g.dart';

@JsonSerializable()
class WeatherLocationModel extends Equatable {
  final WeatherModel weather;
  final LocationModel location;

  const WeatherLocationModel({
    required this.weather,
    required this.location,
  });

  factory WeatherLocationModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherLocationModelToJson(this);

  @override
  List<Object?> get props => [weather, location];
}
