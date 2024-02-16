import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/helpers.dart';

void main() {
  group('Conversion Tests', () {
    test('Fahrenheit to Celsius conversion', () {
      expect(fahrenheitToCelsius(32), 0); // Freezing point of water
      expect(fahrenheitToCelsius(212), 100); // Boiling point of water
      expect(fahrenheitToCelsius(98.6),
          closeTo(37, 0.1)); // Normal body temperature
    });

    test('Miles per hour to Kilometers per hour conversion', () {
      expect(mphToKph(1), closeTo(1.60934, 0.001)); // Basic conversion
      expect(mphToKph(60), closeTo(96.5604, 0.001)); // Highway speed
      // Adding a test for 0 mph to ensure the conversion handles it correctly
      expect(mphToKph(0), 0);
    });
  });

  group('SnackBar Duration Tests', () {
    test('returns base duration for short messages', () {
      String shortMessage = 'Short message';
      expect(getSnackBarDuration(shortMessage), const Duration(seconds: 3));
    });

    test('returns base duration plus one for messages of 50 characters', () {
      String exact50CharsMessage =
          'This message is exactly fifty characters long!!';
      expect(
          getSnackBarDuration(exact50CharsMessage), const Duration(seconds: 3));
    });

    test('returns correct duration for long messages', () {
      String longMessage =
          'This message is longer than fifty characters and should have an additional second for every 50 characters.';
      // This message has 111 characters, so it should result in 3 (base) + 2 (additional) seconds
      expect(getSnackBarDuration(longMessage), const Duration(seconds: 5));
    });

    test('returns base duration for empty messages', () {
      String emptyMessage = '';
      expect(getSnackBarDuration(emptyMessage), const Duration(seconds: 3));
    });
  });

  group('Time Utilities Tests', () {
    // Testing getCurrentTime can only indirectly assert the format and that it represents "now"
    test('getCurrentTime returns the correct format', () {
      String currentTime = getCurrentTime();
      // Verify the format matches yyyy-MM-ddTHH:00
      expect(
          DateFormat("yyyy-MM-ddTHH:00").parse(currentTime), isA<DateTime>());
    });

    test('isTimeBefore correctly identifies earlier times', () {
      String time1 = "2022-01-01T10:00";
      String time2 = "2022-01-01T11:00";
      expect(isTimeBefore(time1, time2), true);
      expect(isTimeBefore(time2, time1),
          false); // Reverse the times to ensure it returns false
    });

    test('isTimeSame correctly identifies identical times', () {
      String time1 = "2022-01-01T10:00";
      String time2 = "2022-01-01T10:00";
      expect(isTimeSame(time1, time2), true);

      String time3 = "2022-01-01T11:00";
      expect(isTimeSame(time1, time3),
          false); // Different times should return false
    });
  });
}
