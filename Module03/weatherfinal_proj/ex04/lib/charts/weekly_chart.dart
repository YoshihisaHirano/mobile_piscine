import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyTemperatureChart extends StatelessWidget {
  final List<double> temperatureMins;
  final List<double> temperatureMaxs;
  final List<String> days;

  const WeeklyTemperatureChart(
      {required this.temperatureMaxs,
      required this.temperatureMins,
      required this.days});

  LineChartData get hourlyTemperatureData => LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [lineChartBarDataMin, lineChartBarDataMax],
        minX: 0,
        maxX: 6,
        maxY: temperatureMaxs.reduce(max).ceilToDouble() + 1,
        minY: temperatureMins.reduce(min).floorToDouble() - 1,
      );

  LineChartBarData get lineChartBarDataMin => LineChartBarData(
        isCurved: false,
        color: Colors.blueAccent,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          temperatureMins.length,
          (index) => FlSpot(index.toDouble(), temperatureMins[index]),
        ),
      );

  LineChartBarData get lineChartBarDataMax => LineChartBarData(
        isCurved: false,
        color: Colors.primaries[0],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          temperatureMaxs.length,
          (index) => FlSpot(index.toDouble(), temperatureMaxs[index]),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: Colors.primaries[0].withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(days[value.toInt()].split('-').sublist(1).join('/')),
    );
  }

  SideTitles get leftTitles {
    double minTemp = temperatureMins.reduce(min).floorToDouble();
    double maxTemp = temperatureMaxs.reduce(max).ceilToDouble();
    double tempDifference = maxTemp - minTemp;

    double interval = tempDifference / 3;

    return SideTitles(
      getTitlesWidget: leftTitleWidgets,
      showTitles: true,
      interval: interval,
      reservedSize: 34,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max || value == meta.min) return const SizedBox();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text('${value.toInt()}°'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Add a colored box and a text widget for each line on the chart
                  Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        color: Colors.primaries[
                            0], // Match this color with the color of the line on the chart
                      ),
                      const SizedBox(width: 5),
                      const Text('Max'), // Describe what this line represents
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        color: Colors.blueAccent, // Match this color with the color of the line on the chart
                      ),
                      const SizedBox(width: 5),
                      const Text('Min'), // Describe what this line represents
                    ],
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                    right: 1,
                    left: 1,
                    top: MediaQuery.of(context).size.height * 0.012),
                child: LineChart(hourlyTemperatureData),
              ))
            ]));
  }
}
