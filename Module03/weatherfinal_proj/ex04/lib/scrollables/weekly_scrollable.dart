import 'package:flutter/material.dart';

class WeeklyWeatherTile {
  final String day;
  final double temperatureMax;
  final double temperatureMin;
  final IconData weatherCondition;

  WeeklyWeatherTile({
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCondition,
    required this.day,
  });
}

class WeeklyWeatherScrollable extends StatelessWidget {
  final List<WeeklyWeatherTile> weatherData;

  WeeklyWeatherScrollable({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: weatherData.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 95, // adjust width to fit your needs
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    weatherData[index].day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.018),
                  )),
              Container(
                width: 90,
                color: Colors.blueGrey
                    .withOpacity(0.15), // Set the background color you want
                child: Column(
                  children: [
                    Text('max: ${weatherData[index].temperatureMax.toString()}°', style: TextStyle(color: Colors.primaries[0], fontWeight: FontWeight.w500),),
                    Text('min: ${weatherData[index].temperatureMin.toString()}°', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),),
                    Padding(
                        padding: const EdgeInsets.all(3),
                        child: Icon(
                          weatherData[index].weatherCondition,
                          size: 24,
                        )),
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
