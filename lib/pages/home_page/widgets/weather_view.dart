import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather/models/location_model/location_model.dart';
import 'package:weather/models/weather_location_model/weather_location_model.dart';
import 'package:weather/models/weather_model/daily_details_model.dart';
import 'package:weather/models/weather_model/weather_details_model.dart';
import 'package:weather/models/weather_model/weather_model.dart';
import 'package:weather/services/preference_service/preference_service.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/helpers.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherView extends StatefulWidget {
  const WeatherView(
      {super.key, required this.weatherLocation, required this.measureSystem});
  final WeatherLocationModel weatherLocation;
  final MeasureSystem measureSystem;

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late WeatherModel weather;
  late LocationModel location;

  @override
  void initState() {
    super.initState();
    weather = widget.weatherLocation.weather;
    location = widget.weatherLocation.location;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCurrentForecast(context),
        const SizedBox(height: 40),
        buildHourlyForecast(context),
        const SizedBox(height: 25),
        buildWeekForecast(),
        const SizedBox(height: 25),
        buildWindHumidity(),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget buildWindHumidity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildValueContainer(
            title: "Wind Speed",
            value: Row(
              children: [
                Text(
                  widget.measureSystem == MeasureSystem.imperial
                      ? "${weather.getWeatherCurrentHour!.windSpeed_10m}"
                      : mphToKph(weather.getWeatherCurrentHour!.windSpeed_10m)
                          .toStringAsFixed(2),
                  style: WeatherFont.lg(context).copyWith(color: Colors.black),
                ),
                Text(
                  widget.measureSystem.speed,
                  style: WeatherFont.md(context),
                ),
              ],
            ),
            icon: WeatherIcons.wind),
        buildValueContainer(
            title: "Humidity",
            value: Text(
              "${weather.getWeatherCurrentHour!.relativeHumidity_2m}%",
              style: WeatherFont.lg(context).copyWith(color: Colors.black),
            ),
            icon: WeatherIcons.humidity),
      ],
    );
  }

  Widget buildValueContainer(
      {required String title, required Widget value, required IconData icon}) {
    return Container(
      height: 145,
      width: 170,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffF0F0F0),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 14,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              title,
              style:
                  WeatherFont.md(context).copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: value,
        ),
      ),
    );
  }

  Widget buildWeekForecast() {
    List<DailyDetailsModel> dailyDetails = [];

    for (int i = 0; i < weather.daily.time.length; i++) {
      DailyDetailsModel? daily = weather.getDailyDetailsByIndex(i);
      if (daily == null) {
        continue;
      }

      dailyDetails.add(daily);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffF0F0F0),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Row(
              children: [
                Text(
                  "7-Day Forecast",
                  style: WeatherFont.md(context)
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: dailyDetails.asMap().entries.map((entry) {
              int index = entry.key;
              DailyDetailsModel e = entry.value;
              return buildDay(
                context,
                title: index == 0 ? "Today" : e.date,
                minTemp: e.temperature_2mMin,
                maxTemp: e.temperature_2mMax,
                weatherIcon: e.weatherIcon,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildDay(BuildContext context,
      {required String title,
      required IconData weatherIcon,
      required double minTemp,
      required double maxTemp}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: WeatherFont.md(context).copyWith(
                  fontWeight: title.toLowerCase() == "today"
                      ? FontWeight.bold
                      : FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Icon(weatherIcon, size: 24),
          ),
          Expanded(
              child: Temperature(
            measureSystem: widget.measureSystem,
            temperature: minTemp,
            style: WeatherFont.md(context)
                .copyWith(color: Colors.black.withOpacity(0.6)),
            tempFontWeight: FontWeight.w500,
            signFontWeight: FontWeight.w500,
          )),
          Expanded(
              child: Temperature(
            measureSystem: widget.measureSystem,
            temperature: maxTemp,
            style: WeatherFont.md(context).copyWith(color: Colors.black),
            tempFontWeight: FontWeight.w500,
            signFontWeight: FontWeight.w500,
          )),
        ],
      ),
    );
  }

  Widget buildHourlyForecast(BuildContext context) {
    List<WeatherDetailsModel> hourDetails = [];
    String currentTime = getCurrentTime();

    for (int i = 0; i < min(weather.hourly.time.length, 32); i++) {
      WeatherDetailsModel? details = weather.getWeatherDetailsByIndex(i);

      if (details == null || isTimeBefore(details.time, currentTime)) {
        continue;
      }

      hourDetails.add(details);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xffF0F0F0),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Row(
              children: [
                Text(
                  "Hourly Forecast",
                  style: WeatherFont.md(context)
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: hourDetails
                  .map((e) => buildHour(context,
                      title: isTimeSame(e.time, currentTime)
                          ? "Now"
                          : e.singleHour,
                      temp: e.temperature_2m,
                      weatherIcon: e.weatherIcon))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHour(BuildContext context,
      {required String title,
      required double temp,
      required IconData weatherIcon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 28),
      child: Column(
        children: [
          Text(title,
              style: WeatherFont.md(context)
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Icon(weatherIcon),
          const SizedBox(height: 12),
          Temperature(
            measureSystem: widget.measureSystem,
            temperature: temp,
            style: WeatherFont.md(context).copyWith(color: Colors.black),
            tempFontWeight: FontWeight.bold,
            signFontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget buildCurrentForecast(BuildContext context) {
    return Column(
      children: [
        Text(
          location.city!,
          style: WeatherFont.lg(context).copyWith(fontWeight: FontWeight.w500),
        ),
        Icon(
          weather.getWeatherCurrentHour!.weatherIcon,
          size: 46,
        ),
        const SizedBox(height: 20),
        Temperature(
          measureSystem: widget.measureSystem,
          temperature: weather.getWeatherCurrentHour!.temperature_2m,
        ),
        Text(
          weather.getWeatherCurrentHour!.weatherDescription,
          style: WeatherFont.md(context).copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lo:",
              style: WeatherFont.md(context),
            ),
            Temperature(
              measureSystem: widget.measureSystem,
              temperature: weather.daily.temperature_2mMin[0],
              style: WeatherFont.md(context).copyWith(color: Colors.black),
              tempFontWeight: FontWeight.w400,
              signFontWeight: FontWeight.w400,
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hi:",
                  style: WeatherFont.md(context),
                ),
                Temperature(
                  measureSystem: widget.measureSystem,
                  temperature: weather.daily.temperature_2mMax[0],
                  style: WeatherFont.md(context).copyWith(color: Colors.black),
                  tempFontWeight: FontWeight.w400,
                  signFontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
