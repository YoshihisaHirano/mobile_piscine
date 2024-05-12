import 'package:flutter/material.dart';
import 'package:weatherFinalProj/error_text.dart';
import 'package:weatherFinalProj/services/weather.dart';
import 'package:weatherFinalProj/utils/weather-codes-icons.dart';

class CurrentWeatherView extends StatefulWidget {
  final double lat;
  final double lon;

  CurrentWeatherView({required this.lat, required this.lon});

  @override
  _CurrentWeatherViewState createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  late Future<Map<String, String>> data;

  @override
  void initState() {
    super.initState();
    data = fetchCurrentWeather(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ErrorText(error: 'Failed to load current weather data');
        } else {
          return Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  snapshot.data!['temperature']!,
                  style: TextStyle(fontSize: 44, color: Colors.primaries[0], fontWeight: FontWeight.w800),
                )),
            Flex(direction: Axis.vertical, children: [
              Icon(
                weatherCodesIcons[snapshot.data!['weatherDescription']] ??
                    Icons.sunny,
                size: 64,
              ),
              Text(
                snapshot.data!['weatherDescription']!,
                style: const TextStyle(fontSize: 24, height: 2),
              )
            ]),
            Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.air)),
                      Text(
                        snapshot.data!['windSpeed']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ])),
          ]);
        }
      },
    );
  }
}
