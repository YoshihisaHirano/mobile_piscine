import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HourlyTemperatureChart extends StatelessWidget {
  final List<double> temperatures;
  final List<String> hours =
      List<String>.generate(24, (i) => i < 10 ? '0$i' : i.toString());

  HourlyTemperatureChart({required this.temperatures});

  LineChartData get hourlyTemperatureData => LineChartData(
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [lineChartBarData],
        minX: 0,
        maxX: 23,
        maxY: temperatures.reduce(max).ceilToDouble(),
        minY: temperatures.reduce(min).floorToDouble(),
      );

  FlGridData get gridData => const FlGridData(show: true);

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

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.primaries[0],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          temperatures.length,
          (index) => FlSpot(index.toDouble(), temperatures[index]),
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
        interval: 4,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: value < 10 ? Text('0${value.toInt()}') : Text('${value.toInt()}'),
    );
  }

  SideTitles get leftTitles {
    double minTemp = temperatures.reduce(min).floorToDouble();
    double maxTemp = temperatures.reduce(max).ceilToDouble();
    double tempDifference = maxTemp - minTemp;

    double interval = tempDifference / 4;

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
