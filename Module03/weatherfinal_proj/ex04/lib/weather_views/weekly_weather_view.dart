import 'package:flutter/material.dart';
import 'package:weatherFinalProj/charts/weekly_chart.dart';
import 'package:weatherFinalProj/error_text.dart';
import 'package:weatherFinalProj/scrollables/weekly_scrollable.dart';
import 'package:weatherFinalProj/services/weather.dart';
import 'package:weatherFinalProj/utils/weather-codes-icons.dart';

class WeeklyWeatherView extends StatefulWidget {
  final double lat;
  final double lon;

  WeeklyWeatherView({required this.lat, required this.lon});

  @override
  _WeeklyWeatherViewState createState() => _WeeklyWeatherViewState();
}

class _WeeklyWeatherViewState extends State<WeeklyWeatherView> {
  late Future<List<DailyWeatherData>> data;
  static List<String> columns = ['Day', 'Weather', 'Max Temp', 'Min Temp'];

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
          return const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ErrorText(error: 'Failed to load 7 days weather data');
        } else {
          List<DailyWeatherData> weatherRows = snapshot.data ?? [];
          List<double> temperatureMins = weatherRows
              .map((DailyWeatherData weatherData) =>
                  double.parse(weatherData.temperatureMin))
              .toList();
          List<double> temperatureMaxs = weatherRows
              .map((DailyWeatherData weatherData) =>
                  double.parse(weatherData.temperatureMax))
              .toList();
          List<String> days = weatherRows
              .map((DailyWeatherData weatherData) => weatherData.day)
              .toList();

          return Column(
            children: [
              WeeklyTemperatureChart(
                temperatureMaxs: temperatureMaxs,
                temperatureMins: temperatureMins,
                days: days,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                child: WeeklyWeatherScrollable(
                  weatherData: weatherRows
                      .map((DailyWeatherData weatherData) => WeeklyWeatherTile(
                            day: weatherData.day.split('-').sublist(1).join('.'),
                            temperatureMax:
                                double.parse(weatherData.temperatureMax),
                            temperatureMin:
                                double.parse(weatherData.temperatureMin),
                            weatherCondition: weatherCodesIcons[
                                    weatherData.weatherDescription] ??
                                Icons.error,
                          ))
                      .toList(),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
