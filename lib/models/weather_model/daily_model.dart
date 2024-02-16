import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/models/weather_model/daily_details_model.dart';

part 'daily_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyModel extends Equatable {
  final List<String> time;
  final List<double> temperature_2mMin;
  final List<double> temperature_2mMax;
  final List<double> precipitationSum;
  final List<int> weatherCode;

  const DailyModel({
    required this.time,
    required this.temperature_2mMin,
    required this.temperature_2mMax,
    required this.precipitationSum,
    required this.weatherCode,
  });

  factory DailyModel.fromJson(Map<String, dynamic> json) =>
      _$DailyModelFromJson(json);
  Map<String, dynamic> toJson() => _$DailyModelToJson(this);

  DailyDetailsModel? getDailyDetailsByDate(String searchDate) {
    int index = time.indexOf(searchDate);

    index = index != -1 ? index : 0;

    return index != -1
        ? DailyDetailsModel(
            time: time[index],
            temperature_2mMin: temperature_2mMin[index],
            temperature_2mMax: temperature_2mMax[index],
            precipitationSum: precipitationSum[index],
            weatherCode: weatherCode[index])
        : null;
  }

  DailyDetailsModel? getDailyDetailsByIndex(int index) {
    if (index < 0 || index > time.length) {
      return null;
    }

    return DailyDetailsModel(
        time: time[index],
        temperature_2mMin: temperature_2mMin[index],
        temperature_2mMax: temperature_2mMax[index],
        precipitationSum: precipitationSum[index],
        weatherCode: weatherCode[index]);
  }

  @override
  List<Object> get props => [
        time,
        temperature_2mMin,
        temperature_2mMax,
        precipitationSum,
        weatherCode,
      ];
}
