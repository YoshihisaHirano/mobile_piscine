import 'package:flutter/material.dart';
import 'package:weatherFinalProj/charts/hourly_chart.dart';
import 'package:weatherFinalProj/error_text.dart';
import 'package:weatherFinalProj/scrollables/hourly_scrollable.dart';
import 'package:weatherFinalProj/services/weather.dart';
import 'package:weatherFinalProj/utils/weather-codes-icons.dart';

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
          return const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ErrorText(
              error: 'Failed to load today\'s hourly weather data');
        } else {
          List<double> temperatures = snapshot.data!
              .map((HourlyWeatherData weatherData) =>
                  double.parse(weatherData.temperature))
              .toList();
          List<IconData> weatherConditions = snapshot.data!
              .map((HourlyWeatherData weatherData) =>
                  weatherCodesIcons[weatherData.weatherDescription] ??
                  Icons.error)
              .toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HourlyTemperatureChart(
                temperatures: temperatures,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                  child: HourlyWeatherScrollable(
                weatherData: [
                  for (var i = 0; i < snapshot.data!.length; i++)
                    HourlyWeatherTile(
                      timeOfDay: snapshot.data![i].hour.split('T')[1],
                      temperature: double.parse(snapshot.data![i].temperature),
                      weatherCondition: weatherConditions[i],
                      windSpeed: double.parse(snapshot.data![i].windSpeed),
                    )
                ],
              )),
            ],
          );
        }
      },
    );
  }
}
