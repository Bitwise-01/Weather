import 'package:flutter_test/flutter_test.dart';
import 'package:weather/models/location_model/location_model.dart';

void main() {
  group('LocationModel', () {
    test('fromJson should return a valid model', () {
      final Map<String, dynamic> json = {
        'id': '1',
        'country': 'CountryName',
        'region': 'RegionName',
        'city': 'CityName',
        'lat': '123',
        'lon': '456'
      };
      final result = LocationModel.fromJson(json);

      expect(result, isA<LocationModel>());
      expect(result.id, '1');
      expect(result.country, 'CountryName');
      expect(result.region, 'RegionName');
      expect(result.city, 'CityName');
      expect(result.lat, '123');
      expect(result.lon, '456');
    });

    test('toJson should return a JSON map containing all data', () {
      const model = LocationModel(
        id: '1',
        country: 'CountryName',
        region: 'RegionName',
        city: 'CityName',
        lat: '123',
        lon: '456',
      );
      final Map<String, dynamic> json = model.toJson();

      expect(json['id'], '1');
      expect(json['country'], 'CountryName');
      expect(json['region'], 'RegionName');
      expect(json['city'], 'CityName');
      expect(json['lat'], '123');
      expect(json['lon'], '456');
    });

    test('toString should return the correct string representation', () {
      const model = LocationModel(
        id: '1',
        country: 'CountryName',
        region: 'RegionName',
        city: 'CityName',
        lat: '123',
        lon: '456',
      );
      final String stringRepresentation = model.toString();

      expect(stringRepresentation, contains('LocationModel{'));
      expect(stringRepresentation, contains('id: 1'));
      expect(stringRepresentation, contains('country: CountryName'));
      expect(stringRepresentation, contains('region: RegionName'));
      expect(stringRepresentation, contains('city: CityName'));
      expect(stringRepresentation, contains('lat: 123'));
      expect(stringRepresentation, contains('lon: 456'));
    });

    test('Equatable properties are correctly utilized for equality', () {
      const model1 = LocationModel(
        id: '1',
        country: 'CountryName',
        region: 'RegionName',
        city: 'CityName',
        lat: '123',
        lon: '456',
      );
      const model2 = LocationModel(
        id: '1',
        country: 'CountryName',
        region: 'RegionName',
        city: 'CityName',
        lat: '123',
        lon: '456',
      );
      expect(model1, equals(model2));
    });
  });
}
