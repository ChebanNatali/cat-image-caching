import 'package:catimage/features/presentation/pages/today_tab.dart';
import 'package:flutter/material.dart';

import 'history_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [TodayTab(), HistoryTab()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Сегодня"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "История"),
        ],
      ),
      // ),
    );
  }
}
