import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weatherAppV2proj/services/geocoding.dart';
import 'package:weatherAppV2proj/utils/get_location_string.dart';

class LocationSearchBar extends StatefulWidget {
  final Function(String) onLocationChange;
  const LocationSearchBar({super.key, required this.onLocationChange});
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
              } else {
                var locationString = getLocationString(location[0]);
                controller.text = locationString;
                widget.onLocationChange(locationString);
              }
              focusNode.unfocus();
            },
            decoration: const InputDecoration(
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
        String locationString = getLocationString(suggestion);
        widget.onLocationChange(locationString);
      },
    );
  }
}
