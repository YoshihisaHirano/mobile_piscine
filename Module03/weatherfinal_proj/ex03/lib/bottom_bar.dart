import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  final List<Widget> _tabIcons = [
    const Icon(
      Icons.access_time,
      size: 16,
    ),
    const Icon(Icons.calendar_today, size: 16),
    const Icon(Icons.date_range, size: 16),
  ];

  BottomBarWidget({super.key, required this.tabController, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: TabBar(
          controller: tabController,
          tabs: tabs.asMap().entries.map((entry) {
            int idx = entry.key;
            String tab = entry.value;
            return Tab(
              height: 60,
              iconMargin: const EdgeInsets.only(bottom: 8),
              icon: _tabIcons[idx],
              child: Text(tab, style: const TextStyle(fontSize: 12)),
            );
          }).toList(),
        ));
  }
}
