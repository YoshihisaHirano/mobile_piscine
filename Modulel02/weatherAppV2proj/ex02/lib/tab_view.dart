import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';

class TabViewWidget extends StatelessWidget {
  final String tabName;
  final String location;
  final LatLng? locationCoordinates;

  const TabViewWidget(
      {super.key, required this.tabName, required this.location, this.locationCoordinates});

  @override
  Widget build(BuildContext context) {
    print(locationCoordinates);
    return Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tabName,
                  style: const TextStyle(
                      fontSize: 44, fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    location.isEmpty ? "Select a location" : location,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ));
  }
}
