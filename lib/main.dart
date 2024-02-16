import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weather/weather_cubit.dart';
import 'package:weather/router/router.dart';
import 'package:weather/services/api_service/api_service.dart';
import 'package:weather/utils/constants.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(ApiService()),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: WeatherColors.primary),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
