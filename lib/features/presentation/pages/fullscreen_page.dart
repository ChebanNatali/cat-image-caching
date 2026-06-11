import 'package:flutter/material.dart';

class FullscreenPage extends StatefulWidget {
  const FullscreenPage({super.key});

  @override
  State<FullscreenPage> createState() => _FullscreenPageState();
}

class _FullscreenPageState extends State<FullscreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("FullscreenPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('FullscreenPage')],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
