import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/geolocation_button.dart';
import 'package:weatherAppV2proj/location_search_bar.dart';

class AppBarWidget extends StatefulWidget {
  final Function(String) onLocationChange;
  final Function(double, double) onCoordinatesChange;
  final Function() clearCoordinates;

  const AppBarWidget({super.key, required this.onLocationChange, required this.onCoordinatesChange, required this.clearCoordinates});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  void onGeolocationClick(String value) {
    widget.onLocationChange(value);
    // print(value);
  }

  void onSubmitLocation(String value) {
    widget.onLocationChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(children: [
          Expanded(
              child: LocationSearchBar(
            onLocationChange: onSubmitLocation,
            onCoordinatesChange: widget.onCoordinatesChange,
            clearCoordinates: widget.clearCoordinates,
          )),
          GeolocationButtonWidget(onLocationChange: onGeolocationClick, onCoordinatesChange: widget.onCoordinatesChange),
        ]));
  }
}
