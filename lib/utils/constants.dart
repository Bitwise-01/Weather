import 'package:flutter/material.dart';

class WeatherColors {
  static const Color primary = Color(0xff0091AD);
}

class WeatherFont {
  static TextStyle getTextStyle(BuildContext context, {required double size}) {
    return TextStyle(
      fontFamily: 'Lato',
      fontSize: size,
    );
  }

  static TextStyle xs(BuildContext context) => getTextStyle(context, size: 12);
  static TextStyle sm(BuildContext context) => getTextStyle(context, size: 13);
  static TextStyle md(BuildContext context) => getTextStyle(context, size: 16);
  static TextStyle lg(BuildContext context) => getTextStyle(context, size: 35);
  static TextStyle xl(BuildContext context) => getTextStyle(context, size: 65);
}
