import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:weatherAppV2proj/app_bar.dart';
import 'package:weatherAppV2proj/bottom_bar.dart';
import 'package:connectivity/connectivity.dart';
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
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _error = details.exception.toString();
      });
    };
  }

  void _clearError() {
    _error = null;
  }

  void _setError(String message) {
    _error = message;
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
    return FutureBuilder<ConnectivityResult>(
      future: Connectivity().checkConnectivity(),
      builder:
          (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == ConnectivityResult.none) {
          return const Scaffold(
              body: Center(
                  child: Text(
            'No internet connection. Please connect your device to the internet and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent,
            ),
          )));
        } else {
          return Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: AppBarWidget(
                    setError: _setError,
                    clearError: _clearError,
                    onLocationChange: _onLocationChange,
                    onCoordinatesChange: _onCoordinatesChange,
                    clearCoordinates: _clearCoordinates,
                  ),
                ),
              ),
              bottomNavigationBar: BottomBarWidget(
                tabs: _tabs,
                tabController: _tabController,
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  for (var tab in _tabs)
                    TabViewWidget(
                      error: _error,
                      tabName: tab,
                      location: _location,
                      locationCoordinates: _locationCoordinates,
                    ),
                ],
              ));
        }
      },
    );
  }
}
