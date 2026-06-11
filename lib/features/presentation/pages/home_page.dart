import 'package:catimage/features/presentation/bloc/history/history_bloc.dart';
import 'package:catimage/features/presentation/bloc/history/history_event.dart';
import 'package:catimage/features/presentation/pages/history_tab.dart';
import 'package:catimage/features/presentation/pages/today_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _historyTabIndex = 1;
  int _currentTabIndex = 0;

  void _onItemTapped(int index) {
    if (index == _historyTabIndex) {
      context.read<HistoryBloc>().add(const LoadHistoryEvent());
    }
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: const [TodayTab(), HistoryTab()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Сегодня'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        ],
      ),
    );
  }
}
