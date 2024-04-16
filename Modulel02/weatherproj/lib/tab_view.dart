import 'package:flutter/material.dart';

class TabViewWidget extends StatelessWidget {
  final String tabName;
  final String location;

  const TabViewWidget({super.key, required this.tabName, required this.location});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(tabName, style: const TextStyle(fontSize: 52, fontWeight: FontWeight.bold)),
          Text(location, style: const TextStyle(fontSize: 28)),
        ],
      ),
    );
  }
}