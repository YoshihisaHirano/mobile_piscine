import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/services/weather.dart';

class CurrentWeatherView extends StatefulWidget {
  final double lat;
  final double lon;

  CurrentWeatherView({required this.lat, required this.lon});

  @override
  _CurrentWeatherViewState createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  late Future<String> data;

  @override
  void initState() {
    super.initState();
    data = fetchCurrentWeather(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(data.toString());
        }
      },
    );
  }
}
