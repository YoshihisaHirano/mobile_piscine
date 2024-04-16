import 'package:flutter/material.dart';
import 'package:weatherproj/app_bar.dart';
import 'package:weatherproj/bottom_bar.dart';
import 'package:weatherproj/tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBarWidget(onLocationChange: _onLocationChange),
          ),
        ),
        bottomNavigationBar: BottomBarWidget(tabController: _tabController, tabs: _tabs,),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (var tab in _tabs)
              TabViewWidget(
                tabName: tab,
                location: _location,
              )
          ],
        ));
  }
}
