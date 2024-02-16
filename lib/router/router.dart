import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/pages/home_page/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class Routes {
  /// [ Names ]
  static String home = "home";
  static String searchCity = "search-city";

  /// [ Paths ]
  static String homePath = "/$home";
  static String addCityPath = "/$searchCity";
}

final router = GoRouter(
    initialLocation: Routes.homePath,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        name: Routes.home,
        path: Routes.homePath,
        builder: (context, state) => const HomePage(),
      ),
    ]);
