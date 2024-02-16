import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/cubits/weather/weather_cubit.dart';
import 'package:weather/models/location_model/location_model.dart';
import 'package:weather/models/location_model/location_object.dart';
import 'package:weather/pages/home_page/widgets/weather_view.dart';
import 'package:weather/services/location_service/location_service.dart';
import 'package:weather/services/preference_service/preference_service.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationModel? location;
  MeasureSystem? measureSystem;

  bool showRetryLocationBtn = false;
  TextEditingController cityNameController = TextEditingController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    loadLocation(context.read<WeatherCubit>());
    PreferencesService()
        .getMeasurementSystem()
        .then((value) => setState(() => measureSystem = value));
  }

  void _onRefresh(WeatherCubit weatherCubit) async {
    // Clear Cache
    weatherCubit.reset();

    // Fetch new data
    await loadLocation(weatherCubit);

    // Add artifical delay
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    // Missing location
    if (location == null) {
      return _buildLoadingLocationView(context);
    }

    // Loading measure system
    if (measureSystem == null) {
      return _buildLoadingMeasurements();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          header: const WaterDropHeader(
            waterDropColor: WeatherColors.primary,
            complete: Text("Refreshed"),
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(context.read<WeatherCubit>()),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const SizedBox.shrink();
                  } else if (state is WeatherLoaded) {
                    return Column(
                      children: [
                        CustomFormField(
                          controller: cityNameController,
                          borderRadius: BorderRadius.circular(10),
                          fillColor: Colors.black.withOpacity(0.1),
                          suffixIcon: GestureDetector(
                            onTap: searchCity,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: FaIcon(FontAwesomeIcons.magnifyingGlass),
                            ),
                          ),
                          hintText: location == null
                              ? "Rochester, NY"
                              : "${location!.city} ${location!.region}",
                          onFieldSubmitted: (_) => searchCity(),
                        ),
                        GestureDetector(
                          onTap: () {
                            MeasureSystem newMeasureSystem =
                                measureSystem == MeasureSystem.imperial
                                    ? MeasureSystem.metric
                                    : MeasureSystem.imperial;

                            PreferencesService()
                                .saveMeasurementSystem(newMeasureSystem)
                                .then((value) => setState(
                                      () {
                                        measureSystem = newMeasureSystem;

                                        showSuccessSnackBar(context,
                                            "Toggled to ${newMeasureSystem.name} System");
                                      },
                                    ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  MeasureSystem.imperial.name,
                                  style: WeatherFont.md(context)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                FaIcon(
                                    measureSystem == MeasureSystem.imperial
                                        ? FontAwesomeIcons.toggleOn
                                        : FontAwesomeIcons.toggleOff,
                                    size: 20,
                                    color:
                                        measureSystem == MeasureSystem.imperial
                                            ? WeatherColors.primary
                                            : Colors.grey)
                              ],
                            ),
                          ),
                        ),
                        WeatherView(
                            measureSystem: measureSystem!,
                            weatherLocation: state.weatherLocationResponse),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Text("Error: ${state.message}");
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingMeasurements() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Scaffold _buildLoadingLocationView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Loading Location",
                style: WeatherFont.md(context),
              ),
              const SizedBox(
                height: 10,
              ),
              if (showRetryLocationBtn)
                GestureDetector(
                  onTap: () => loadLocation(context.read<WeatherCubit>()),
                  child: Text(
                    "Retry",
                    style: WeatherFont.md(context).copyWith(
                      color: WeatherColors.primary,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadLocation(WeatherCubit weatherCubit) async {
    setState(() => showRetryLocationBtn = false);

    if (location != null) {
      await weatherCubit.fetchWeather(location!);
      return;
    }

    try {
      final value = await LocationService.getCurrentLocation();
      setState(() => location = LocationModel.fromJson(value.toJson()));
      await weatherCubit.fetchWeather(location!);
    } catch (e) {
      // We should log this
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (location == null) {
        setState(() => showRetryLocationBtn = true);
      }
    });
  }

  void searchCity() {
    if (cityNameController.text.isEmpty) {
      return;
    }

    _checkSetLocation(context, query: cityNameController.text)
        .then((newLocation) {
      cityNameController.clear();
      setState(() => location = newLocation);
      loadLocation(context.read<WeatherCubit>());
    });
  }

  Future<LocationModel?> _checkSetLocation(BuildContext context,
      {required String query}) async {
    LocationObject? locationObject = await lookupAddr(query);

    if (locationObject == null) {
      if (context.mounted) {
        showErrorSnackBar(context, "City lookup failed");
      }
      return null;
    }

    return LocationModel.fromJson(locationObject.toJson());
  }

  Future<LocationObject?> lookupAddr(String query) async {
    try {
      List<Location> locations = await locationFromAddress(
        query,
      );
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return LocationService.coordinatesToLocation(
            location.latitude, location.longitude);
      }
    } catch (e) {
      // Log
    }

    return null;
  }
}
