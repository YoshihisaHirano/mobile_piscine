import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/services/weather.dart';

class WeeklyWeatherView extends StatefulWidget {
  final double lat;
  final double lon;

  WeeklyWeatherView({required this.lat, required this.lon});

  @override
  _WeeklyWeatherViewState createState() => _WeeklyWeatherViewState();
}

class _WeeklyWeatherViewState extends State<WeeklyWeatherView> {
  late Future<List<DailyWeatherData>> data;

  @override
  void initState() {
    super.initState();
    data = fetchDailyWeather(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyWeatherData>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data.toString(),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center);
        }
      },
    );
  }
}
