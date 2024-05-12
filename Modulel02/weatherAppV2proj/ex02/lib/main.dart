import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:weatherAppV2proj/app_bar.dart';
import 'package:weatherAppV2proj/bottom_bar.dart';
import 'package:weatherAppV2proj/tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Proj V2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String _location = "";
  LatLng? _locationCoordinates;
  late TabController _tabController;
  final List<String> _tabs = ["Currently", "Today", "Weekly"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onLocationChange(String value) {
    setState(() {
      _location = value;
    });
  }

  void _onCoordinatesChange(double lat, double lon) {
    setState(() {
      _locationCoordinates = LatLng(lat, lon);
    });
  }

  void _clearCoordinates() {
    setState(() {
      _locationCoordinates = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBarWidget(
                onLocationChange: _onLocationChange,
                onCoordinatesChange: _onCoordinatesChange,
                clearCoordinates: _clearCoordinates),
          ),
        ),
        bottomNavigationBar: BottomBarWidget(
          tabController: _tabController,
          tabs: _tabs,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (var tab in _tabs)
              TabViewWidget(
                tabName: tab,
                location: _location,
                locationCoordinates: _locationCoordinates,
              )
          ],
        ));
  }
}
