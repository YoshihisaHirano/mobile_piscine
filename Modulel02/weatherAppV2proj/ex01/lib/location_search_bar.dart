import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weatherAppV2proj/services/geocoding.dart';

class LocationSearchBar extends StatefulWidget {
  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            onTapOutside: (event) => focusNode.unfocus(),
            // autofocus: true,
            decoration: const InputDecoration(
              // border: OutlineInputBorder(),
              labelText: 'Search location',
            ));
      },
      suggestionsCallback: (pattern) async {
        if (pattern.length >= 3) {
          var places = await fetchLocations(pattern);
          print(places[0]);
          return places;
        } else {
          return [];
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion["display_name"]),
        );
      },
      onSelected: (suggestion) {
        _controller.text = suggestion;
      },
    );
  }
}
