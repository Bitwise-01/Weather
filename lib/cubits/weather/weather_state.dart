part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherLocationModel weatherLocationResponse;
  const WeatherLoaded(this.weatherLocationResponse);

  @override
  List<Object> get props => [weatherLocationResponse];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
