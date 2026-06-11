import 'package:catimage/core/core.dart';
import 'package:flutter/material.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({super.key});

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Core.colors.backgroundColor,

        title: Text("TodayTab"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('TodayTab')],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
