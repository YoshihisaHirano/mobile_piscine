import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/geolocation_button.dart';
import 'package:weatherAppV2proj/location_search_bar.dart';

class AppBarWidget extends StatefulWidget {
  final Function(String) onLocationChange;
  final Function(double, double) onCoordinatesChange;
  final Function() clearCoordinates;
  final Function() clearError;
  final Function(String) setError;

  const AppBarWidget(
      {super.key,
      required this.onLocationChange,
      required this.onCoordinatesChange,
      required this.clearCoordinates,
      required this.clearError,
      required this.setError
      });

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  void onGeolocationClick(String value) {
    widget.onLocationChange(value);
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
            clearError: widget.clearError,
            setError: widget.setError,
          )),
          GeolocationButtonWidget(
              onLocationChange: onGeolocationClick,
              onCoordinatesChange: widget.onCoordinatesChange,
              setError: widget.setError,
              clearError: widget.clearError,
              ),
        ]));
  }
}
