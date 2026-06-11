import 'package:catimage/core/core.dart';
import 'package:catimage/di_container.dart';
import 'package:catimage/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Core.theme.themeData(context),
      home: HomePage(),
    );
  }
}
