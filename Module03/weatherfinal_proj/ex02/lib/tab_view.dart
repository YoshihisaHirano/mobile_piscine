import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:weatherFinalProj/error_text.dart';
import 'package:weatherFinalProj/weather_views/current_weather_view.dart';
import 'package:weatherFinalProj/weather_views/today_weather_view.dart';
import 'package:weatherFinalProj/weather_views/weekly_weather_view.dart';

class TabViewWidget extends StatelessWidget {
  final String tabName;
  final String location;
  final LatLng? locationCoordinates;
  final String? error;

  const TabViewWidget(
      {super.key,
      required this.tabName,
      required this.location,
      this.locationCoordinates,
      this.error});

  @override
  Widget build(BuildContext context) {
    Widget weatherView;
    double lat = locationCoordinates?.latitude ?? 0;
    double lon = locationCoordinates?.longitude ?? 0;

    bool isLocationInvalid = locationCoordinates == null && location.isNotEmpty;
    bool isErrorPresent = error != null;
    List<String> locationParts = location.split(', ');

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 8, top: MediaQuery.of(context).size.height * 0.03, left: 8, right: 8),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: location.isEmpty
                              ? "Select a location"
                              : locationParts[0],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.038,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            height: 2 // Replace with your secondary color
                          ),
                        ),
                        if (locationParts.length > 1)
                          TextSpan(
                            text: '\n${locationParts.sublist(1).join(', ')}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.024,
                              fontWeight: FontWeight.w500,
                              height: 2
                            ),
                          ),
                      ])),
                ),
                locationCoordinates == null
                    ? const SizedBox()
                    : Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: weatherView,
                      )),
                Column(
                  children: <Widget>[
                    isErrorPresent
                        ? ErrorText(error: error!)
                        : isLocationInvalid
                            ? const ErrorText(
                                error:
                                    'Could not find valid coordinates for the provided address. Please try a different location.',
                              )
                            : Container(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
