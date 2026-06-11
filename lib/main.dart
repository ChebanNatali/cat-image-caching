import 'package:catimage/core/core.dart';
import 'package:catimage/di_container.dart';
import 'package:catimage/features/presentation/bloc/history/history_bloc.dart';
import 'package:catimage/features/presentation/bloc/history/history_event.dart';
import 'package:catimage/features/presentation/bloc/today/today_bloc.dart';
import 'package:catimage/features/presentation/bloc/today/today_event.dart';
import 'package:catimage/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<TodayBloc>()..add(const LoadCachedCatEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<HistoryBloc>()..add(const LoadHistoryEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Core.theme.themeData(context),
        home: const HomePage(),
      ),
    );
  }
}
