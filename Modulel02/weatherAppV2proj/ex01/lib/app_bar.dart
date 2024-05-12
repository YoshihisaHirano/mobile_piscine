import 'package:flutter/material.dart';
import 'package:weatherAppV2proj/geolocation_button.dart';
import 'package:weatherAppV2proj/location_search_bar.dart';
import 'package:weatherAppV2proj/services/geocoding.dart';

class AppBarWidget extends StatefulWidget {
  final Function(String) onLocationChange;

  const AppBarWidget({super.key, required this.onLocationChange});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _locations = [];

  void onGeolocationClick(String value) {
    widget.onLocationChange(value);
    print(value);
    _controller.text = "";
  }

  void onSubmitLocation(String value) {
    widget.onLocationChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 12), child: Row(children: [
      Expanded(
          child: LocationSearchBar(
        onLocationChange: onSubmitLocation,
      )),
      GeolocationButtonWidget(onLocationChange: onGeolocationClick),
    ]));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
