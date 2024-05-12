import 'package:flutter/material.dart';
import 'package:weatherFinalProj/error_text.dart';
import 'package:weatherFinalProj/services/weather.dart';

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
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: columns.map((String column) {
                      return DataColumn(label: Text(column));
                    }).toList(),
                    rows: weatherRows
                        .map<DataRow>((DailyWeatherData weatherData) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(weatherData.day)),
                          DataCell(Text(weatherData.weatherDescription)),
                          DataCell(Text(weatherData.temperatureMax)),
                          DataCell(Text(weatherData.temperatureMin)),
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
