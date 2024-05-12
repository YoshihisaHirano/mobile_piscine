import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/services/weather.dart';

class TodayWeatherView extends StatefulWidget {
  final double lat;
  final double lon;

  TodayWeatherView({required this.lat, required this.lon});

  @override
  _TodayWeatherViewState createState() => _TodayWeatherViewState();
}

class _TodayWeatherViewState extends State<TodayWeatherView> {
  late Future<List<HourlyWeatherData>> data;

  @override
  void initState() {
    super.initState();
    data = fetchHourlyWeather(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HourlyWeatherData>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data.toString());
        }
      },
    );
  }
}