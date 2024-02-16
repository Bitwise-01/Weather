import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/services/preference_service/preference_service.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather_icons/weather_icons.dart';

String getCurrentTime() {
  DateTime now = DateTime.now();
  String formattedNow = DateFormat("yyyy-MM-ddTHH:00").format(now);
  return formattedNow;
}

bool isTimeBefore(String time1, String time2) {
  DateTime dateTime1 = DateTime.parse(time1);
  DateTime dateTime2 = DateTime.parse(time2);
  return dateTime1.isBefore(dateTime2);
}

bool isTimeSame(String time1, String time2) {
  DateTime dateTime1 = DateTime.parse(time1);
  DateTime dateTime2 = DateTime.parse(time2);
  return dateTime1.isAtSameMomentAs(dateTime2);
}

class WeatherCodeDescription {
  static const Map<int, String> codeDescription = {
    0: 'Clear Sky',
    1: 'Mainly Clear',
    2: 'Partly Cloudy',
    3: 'Overcast',
    45: 'Fog',
    48: 'Depositing Rime Fog',
    51: 'Light Drizzle',
    53: 'Moderate Drizzle',
    55: 'Dense Drizzle',
    56: 'Freezing Light Drizzle',
    57: 'Freezing Dense Drizzle',
    61: 'Slight Rain',
    63: 'Moderate Rain',
    65: 'Heavy Rain',
    66: 'Freezing Light Rain',
    67: 'Freezing Heavy Rain',
    71: 'Slight Snow',
    73: 'Moderate Snow',
    75: 'Heavy Snow',
    77: 'Snow Grains',
    80: 'Slight Rain Showers',
    81: 'Moderate Rain Showers',
    82: 'Violent Rain Showers',
    85: 'Slight Snow Showers',
    86: 'Heavy Snow Showers',
    95: 'Slight or Moderate Thunderstorm',
    96: 'Thunderstorm with Slight Hail',
    99: 'Thunderstorm with Heavy Hail',
  };

  static String getDescription(int code) {
    if (codeDescription.containsKey(code)) {
      return codeDescription[code]!;
    }

    if (code >= 1 && code <= 3) {
      return 'Partly Cloudy';
    }
    if (code == 45 || code == 48) {
      return 'Fog';
    }
    if (code >= 51 && code <= 55) {
      return 'Drizzle';
    }
    if (code == 56 || code == 57) {
      return 'Freezing Drizzle';
    }
    if (code >= 61 && code <= 65) {
      return 'Rain';
    }
    if (code == 66 || code == 67) {
      return 'Freezing Rain';
    }
    if (code >= 71 && code <= 75) {
      return 'Snow Fall';
    }
    if (code >= 80 && code <= 82) {
      return 'Rain Showers';
    }
    if (code == 85 || code == 86) {
      return 'Snow Showers';
    }
    return 'Thunderstorm';
  }
}

class WeatherCodeIcon {
  final String? time;
  WeatherCodeIcon({this.time});

  static const Map<int, IconData> dayCodeIcon = {
    0: WeatherIcons.day_sunny,
    1: WeatherIcons.day_sunny,
    2: WeatherIcons.day_cloudy,
    3: WeatherIcons.day_cloudy,
    45: WeatherIcons.day_fog,
    48: WeatherIcons.day_fog,
    51: WeatherIcons.raindrop,
    53: WeatherIcons.raindrops,
    55: WeatherIcons.rain,
    56: WeatherIcons.raindrop,
    57: WeatherIcons.raindrops,
    61: WeatherIcons.rain,
    63: WeatherIcons.raindrop,
    65: WeatherIcons.raindrops,
    66: WeatherIcons.raindrop,
    67: WeatherIcons.raindrops,
    71: WeatherIcons.snowflake_cold,
    73: WeatherIcons.snow,
    75: WeatherIcons.snow_wind,
    77: WeatherIcons.snowflake_cold,
    80: WeatherIcons.raindrops,
    81: WeatherIcons.raindrop,
    82: WeatherIcons.raindrops,
    85: WeatherIcons.snow_wind,
    86: WeatherIcons.snowflake_cold,
    95: WeatherIcons.thunderstorm,
    96: WeatherIcons.thunderstorm,
    99: WeatherIcons.hail,
  };

  static const Map<int, IconData> nightCodeIcon = {
    0: WeatherIcons.night_clear,
    1: WeatherIcons.night_clear,
    2: WeatherIcons.night_cloudy,
    3: WeatherIcons.night_cloudy,
    45: WeatherIcons.night_fog,
    48: WeatherIcons.night_fog,
    51: WeatherIcons.night_rain,
    53: WeatherIcons.night_rain,
    55: WeatherIcons.night_rain,
    56: WeatherIcons.night_rain,
    57: WeatherIcons.night_rain,
    61: WeatherIcons.night_rain,
    63: WeatherIcons.night_rain,
    65: WeatherIcons.night_rain,
    66: WeatherIcons.night_rain,
    67: WeatherIcons.night_rain,
    71: WeatherIcons.night_snow,
    73: WeatherIcons.night_snow,
    75: WeatherIcons.night_snow,
    77: WeatherIcons.night_snow,
    80: WeatherIcons.night_rain,
    81: WeatherIcons.night_rain,
    82: WeatherIcons.night_rain,
    85: WeatherIcons.night_snow,
    86: WeatherIcons.night_snow,
    95: WeatherIcons.night_thunderstorm,
    96: WeatherIcons.night_thunderstorm,
    99: WeatherIcons.night_hail,
  };

  IconData getIcon(int code) {
    Map<int, IconData> icons = isDarkOutside ? nightCodeIcon : dayCodeIcon;
    if (icons.containsKey(code)) {
      return icons[code]!;
    }

    if (code >= 1 && code <= 3) {
      return isDarkOutside ? WeatherIcons.night_cloudy : WeatherIcons.cloudy;
    }
    if (code == 45 || code == 48) {
      return isDarkOutside ? WeatherIcons.night_fog : WeatherIcons.fog;
    }
    if (code >= 51 && code <= 55) {
      return isDarkOutside ? WeatherIcons.night_rain : WeatherIcons.raindrops;
    }
    if (code == 56 || code == 57) {
      return isDarkOutside
          ? WeatherIcons.night_rain_wind
          : WeatherIcons.rain_wind;
    }
    if (code >= 61 && code <= 65) {
      return isDarkOutside ? WeatherIcons.night_rain : WeatherIcons.rain;
    }
    if (code == 66 || code == 67) {
      return isDarkOutside
          ? WeatherIcons.night_rain_wind
          : WeatherIcons.rain_wind;
    }
    if (code >= 71 && code <= 75) {
      return isDarkOutside ? WeatherIcons.night_snow : WeatherIcons.snow;
    }
    if (code >= 80 && code <= 82) {
      return isDarkOutside ? WeatherIcons.night_rain : WeatherIcons.rain;
    }
    if (code == 85 || code == 86) {
      return isDarkOutside ? WeatherIcons.night_snow : WeatherIcons.snow;
    }
    return isDarkOutside
        ? WeatherIcons.night_thunderstorm
        : WeatherIcons.thunderstorm;
  }

  bool get isDarkOutside {
    if (time == null) {
      return isDarkOut;
    }

    // Correcting the format and parsing the user input into a DateTime object
    DateTime inputTime = DateTime.parse(time!);

    // Extracting the hour from the input time
    int hour = inputTime.hour;

    // Defining night time as between 8 PM (20) and 7 AM (7)
    // Since Dart DateTime uses 24-hour format, 8 PM is 20 and 7 AM is 7
    bool isNightTime = hour >= 20 || hour < 7;

    return isNightTime;
  }
}

class Temperature extends StatelessWidget {
  final double temperature;
  final TextStyle? style;
  final FontWeight? tempFontWeight;
  final FontWeight? signFontWeight;
  final MeasureSystem measureSystem;

  const Temperature(
      {super.key,
      required this.temperature,
      required this.measureSystem,
      this.style,
      this.tempFontWeight = FontWeight.w300,
      this.signFontWeight = FontWeight.w200});

  @override
  Widget build(BuildContext context) {
    double temp = temperature;

    if (measureSystem == MeasureSystem.metric) {
      temp = fahrenheitToCelsius(temperature);
    }

    return RichText(
      text: TextSpan(
        style: style ?? WeatherFont.xl(context).copyWith(color: Colors.black),
        children: [
          TextSpan(
            text: "${temp.round()}",
            style: TextStyle(fontWeight: tempFontWeight),
          ),
          TextSpan(
            text: '°',
            style: TextStyle(fontWeight: signFontWeight),
          ),
        ],
      ),
    );
  }
}

bool get isDarkOut {
  // This can be improve to actual get the night time
  final now = DateTime.now();
  final evening = DateTime(now.year, now.month, now.day, 20); // 8 PM
  final morning = DateTime(now.year, now.month, now.day, 7); // 6 AM

  return now.isBefore(morning) || now.isAfter(evening);
}

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function(String)? onFieldSubmitted;
  final BorderRadius borderRadius;
  final Color fillColor;
  final TextStyle style;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final Widget? suffixIcon;

  const CustomFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.fillColor = Colors.white,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.style = const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      obscureText: obscureText,
      style: style,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: borderRadius,
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged ?? (value) {},
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
    );
  }
}

void showSuccessSnackBar(BuildContext context, String message) {
  showSnackBar(context, message, false);
}

void showErrorSnackBar(BuildContext context, String message) {
  showSnackBar(context, message, true);
}

Duration getSnackBarDuration(String message) {
  int baseDuration = 3; // in seconds
  int additionalTime =
      (message.length ~/ 50); // Increase by 1 sec for every 50 chars

  return Duration(seconds: baseDuration + additionalTime);
}

void showSnackBar(BuildContext context, String message, bool isError) {
  final snackBar = SnackBar(
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
    backgroundColor: isError ? Colors.red.shade500 : Colors.green.shade500,
    duration: getSnackBarDuration(message),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

double mphToKph(double mph) {
  return mph * 1.60934;
}
