import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weatherAppV2proj/services/reverse_geocoding.dart';

class GeolocationButtonWidget extends StatefulWidget {
  final Function(String) onLocationChange;
  final Function(double, double) onCoordinatesChange;

  const GeolocationButtonWidget({Key? key, required this.onLocationChange, required this.onCoordinatesChange})
      : super(key: key);

  @override
  _GeolocationButtonWidgetState createState() =>
      _GeolocationButtonWidgetState();
}

class _GeolocationButtonWidgetState extends State<GeolocationButtonWidget> {
  final Location _location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future<void> isServiceEnabled() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }
  }

  Future<void> isPermissionGranted() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }
  }

  void onGeolocationClick() async {
    try {
      await isServiceEnabled();
      if (!_serviceEnabled) {
        widget.onLocationChange(
            "Please enable location services to see weather in your location.");
        return;
      }
      // on iOS it cannot be asked again, once denied
      await isPermissionGranted();
      if (_permissionGranted != PermissionStatus.granted) {
        widget.onLocationChange(
            "Please allow location access to see weather in your location.");
        return;
      }
      _locationData = await _location.getLocation();

      if (_locationData != null) {
        // print(_locationData);
        widget.onCoordinatesChange(
            _locationData!.latitude!, _locationData!.longitude!);
        String place = await fetchPlaceByCoords(
            _locationData!.latitude.toString(),
            _locationData!.longitude.toString());
        widget.onLocationChange(place);
      } else {
        widget.onLocationChange(
            "Please allow location access to see weather in your location.");
      }
    } catch (e) {
      print("Error in onGeolocationClick");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onGeolocationClick,
      icon: const Icon(Icons.my_location),
      tooltip: 'Geolocation',
    );
  }
}
