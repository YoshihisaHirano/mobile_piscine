import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:weatherAppV2proj/weather_views/current_weather_view.dart';
import 'package:weatherAppV2proj/weather_views/today_weather_view.dart';
import 'package:weatherAppV2proj/weather_views/weekly_weather_view.dart';

class TabViewWidget extends StatelessWidget {
  final String tabName;
  final String location;
  final LatLng? locationCoordinates;

  const TabViewWidget(
      {super.key,
      required this.tabName,
      required this.location,
      this.locationCoordinates});

  @override
  Widget build(BuildContext context) {
    Widget weatherView;
    double lat = locationCoordinates?.latitude ?? 0;
    double lon = locationCoordinates?.longitude ?? 0;

    switch (tabName) {
      case 'Currently':
        weatherView = CurrentWeatherView(lat: lat, lon: lon);
        break;
      case 'Today':
        weatherView = TodayWeatherView(lat: lat, lon: lon);
        break;
      default:
        weatherView = WeeklyWeatherView(lat: lat, lon: lon);
    }

    return Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    location.isEmpty ? "Select a location" : location,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              locationCoordinates == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8), child: weatherView)
            ],
          ),
        ));
  }
}
