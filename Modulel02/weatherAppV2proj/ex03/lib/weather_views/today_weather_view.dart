import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/error_text.dart';
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
          return const SizedBox(height: 20, width: 20, child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ErrorText(error: 'Failed to load today\'s hourly weather data');
        } else {
          List<HourlyWeatherData> weatherRows = snapshot.data ?? [];
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Hour'),
                      ),
                      DataColumn(
                        label: Text('Temp'),
                      ),
                      DataColumn(label: Text('Weather')),
                      DataColumn(label: Text('Wind'))
                    ],
                    rows: weatherRows
                        .map<DataRow>((HourlyWeatherData weatherData) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(weatherData.hour)),
                          DataCell(Text(weatherData.temperature.toString())),
                          DataCell(Text(weatherData.weatherDescription)),
                          DataCell(Text(weatherData.windSpeed))
                          // Add more DataCell widgets for other properties of HourlyWeatherData
                        ],
                      );
                    }).toList(),
                  )));
        }
      },
    );
  }
}
