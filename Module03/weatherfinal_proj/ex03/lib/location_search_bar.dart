import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weatherFinalProj/services/geocoding.dart';
import 'package:weatherFinalProj/utils/get_location_string.dart';

class LocationSearchBar extends StatefulWidget {
  final Function(String) onLocationChange;
  final Function(double, double) onCoordinatesChange;
  final Function() clearCoordinates;
  final Function() clearError;
  final Function(String) setError;

  const LocationSearchBar(
      {super.key,
      required this.onLocationChange,
      required this.onCoordinatesChange,
      required this.clearCoordinates,
      required this.clearError,
      required this.setError});

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
              onTap: () => widget.clearError(),
              onSubmitted: (value) async {
                widget.clearError();
                try {
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
                } catch (e) {
                  // print(e);
                  widget.onLocationChange(value);
                  widget.clearCoordinates();
                  widget.setError('Failed to connect to geolocation API');
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
            try {
              var places = await fetchLocations(pattern);
              return places;
            } catch (e) {
              widget.setError('Failed to connect to geolocation API');
            }
          }
          return [];
        },
        itemBuilder: (context, suggestion) {
          List<String> parts = getLocationString(suggestion).split(', ');

          return ListTile(
            leading: const Icon(Icons.place),
            iconColor: Colors.primaries[0],
            title: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: parts[0],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ', ${parts.sublist(1).join(', ')}'),
                ],
              ),
            ),
          );
        },
        onSelected: (suggestion) {
          double lat = double.parse(suggestion["lat"]);
          double lon = double.parse(suggestion["lon"]);
          widget.onCoordinatesChange(lat, lon);
          String locationString = getLocationString(suggestion);
          widget.onLocationChange(locationString);
        },
        errorBuilder: (context, error) => const ListTile(
                title: Text(
              'Failed to connect to API, please try again later',
              style: TextStyle(color: Colors.redAccent),
            )));
  }
}
