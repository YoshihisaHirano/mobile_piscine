import 'package:flutter/material.dart';

class HourlyWeatherTile {
  final String timeOfDay;
  final double temperature;
  final IconData weatherCondition;
  final double windSpeed;

  HourlyWeatherTile({
    required this.timeOfDay,
    required this.temperature,
    required this.weatherCondition,
    required this.windSpeed,
  });
}

class HourlyWeatherScrollable extends StatelessWidget {
  final List<HourlyWeatherTile> weatherData;

  HourlyWeatherScrollable({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: weatherData.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 80, // adjust width to fit your needs
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    weatherData[index].timeOfDay,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.018),
                  )),
              Container(
                width: 75,
                color: Colors.blue
                    .withOpacity(0.2), // Set the background color you want
                child: Column(
                  children: [
                    Text('${weatherData[index].temperature.toString()}°'),
                    Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          weatherData[index].weatherCondition,
                          size: 24,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text('${weatherData[index].windSpeed} km/h'),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
