import 'package:flutter/material.dart';
import 'package:weatherproj/geolocation_button.dart';

class AppBarWidget extends StatefulWidget {
  final Function(String) onLocationChange;

  const AppBarWidget({super.key, required this.onLocationChange});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  void onGeolocationClick(String value) {
    widget.onLocationChange(value);
    print(value);
    _controller.text = "";
  }

  void onSubmitLocation(String value) {
    _controller.text = value;
    widget.onLocationChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onSubmitted: onSubmitLocation,
              onTapOutside: (event) => _focusNode.unfocus(),
              decoration: const InputDecoration(
                hintText: "Search location...",
                prefixIcon: Icon(Icons.search),
              ))),
      // IconButton(
      //   onPressed: onGeolocationClick,
      //   icon: const Icon(Icons.my_location),
      //   tooltip: 'Geolocation',
      // )
      GeolocationButtonWidget(onLocationChange: onGeolocationClick),
    ]);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
