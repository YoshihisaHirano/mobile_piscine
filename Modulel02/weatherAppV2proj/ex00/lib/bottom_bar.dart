import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  final List<Widget> _tabIcons = [
    const Icon(Icons.access_time),
    const Icon(Icons.calendar_today),
    const Icon(Icons.date_range),
  ];

  BottomBarWidget({super.key, required this.tabController, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TabBar(
          controller: tabController,
          tabs: tabs.asMap().entries.map((entry) {
            int idx = entry.key;
            String tab = entry.value;
            return Tab(icon: _tabIcons[idx], text: tab);
          }).toList(),
        ));
  }
}
