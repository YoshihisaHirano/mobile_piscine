import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weatherAppV2proj/services/geocoding.dart';
import 'package:weatherAppV2proj/utils/get_location_string.dart';

class LocationSearchBar extends StatefulWidget {
  final Function(String) onLocationChange;
  final Function(double, double) onCoordinatesChange;
  final Function() clearCoordinates;

  const LocationSearchBar(
      {super.key,
      required this.onLocationChange,
      required this.onCoordinatesChange,
      required this.clearCoordinates});
  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            onTapOutside: (event) => focusNode.unfocus(),
            onSubmitted: (value) async {
              var location = await fetchOneLocation(value);
              if (location.isEmpty) {
                widget.onLocationChange(value);
                widget.clearCoordinates();
              } else {
                var result = location[0];
                double lat = double.parse(result["lat"]);
                double lon = double.parse(result["lon"]);
                widget.onCoordinatesChange(lat, lon);
                var locationString = getLocationString(result);
                controller.text = locationString;
                widget.onLocationChange(locationString);
              }
              focusNode.unfocus();
            },
            decoration: const InputDecoration(
              // border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              labelText: 'Search location',
            ));
      },
      suggestionsCallback: (pattern) async {
        if (pattern.length >= 3) {
          var places = await fetchLocations(pattern);
          return places;
        } else {
          return [];
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(getLocationString(suggestion)),
        );
      },
      onSelected: (suggestion) {
        double lat = double.parse(suggestion["lat"]);
        double lon = double.parse(suggestion["lon"]);
        widget.onCoordinatesChange(lat, lon);
        String locationString = getLocationString(suggestion);
        widget.onLocationChange(locationString);
      },
    );
  }
}
