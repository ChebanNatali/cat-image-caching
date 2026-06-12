import 'package:catimage/core/core.dart';
import 'package:catimage/core/utils/local_store.dart';
import 'package:catimage/features/data/datasources/cat_remote_datasource.dart';
import 'package:catimage/features/data/repositories/cat_repository_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final client = http.Client();
    try {
      final repository = CatRepositoryImpl(
        remoteDatasource: CatRemoteDatasource(client: client),
        localStorage: LocalStorage(),
      );

      switch (taskName) {
        // case BackgroundWorker.everyFifteenMinutesTaskName:
        //   await repository.fetchAndCacheCatImage();

        // case BackgroundWorker.everyTwoHoursTaskName:
        //   await repository.fetchAndCacheCatImage();

        case BackgroundWorker.onceTodayTaskName:
          final cached = await repository.getCachedCatImage();
          final alreadyDownloadedToday =
              cached?.downloadedAt != null &&
              Core.utils.isToday(cached!.downloadedAt!);
          if (!alreadyDownloadedToday) {
            await repository.fetchAndCacheCatImage();
          }
      }
    } finally {
      client.close();
    }

    return true;
  });
}

class BackgroundWorker {
  // static const everyFifteenMinutesTaskName = 'com.catimage.fetch_every_fifteen_minutes';

  // static const everyTwoHoursTaskName = 'com.catimage.fetch_every_two_hours';
  static const onceTodayTaskName = 'com.catimage.fetch_once_today';

  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  /// загрузка каждые 15 минут
  // static Future<void> registerEveryFifteenMinutes() async {
  //   await Workmanager().registerPeriodicTask(
  //     everyFifteenMinutesTaskName,
  //     everyFifteenMinutesTaskName,
  //     frequency: const Duration(minutes: 15),
  //     constraints: Constraints(networkType: NetworkType.connected),
  //     existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
  //   );
  // }

  /// загрузка каждые 2 часа без условий
  // static Future<void> registerEveryTwoHours() async {
  //   await Workmanager().registerPeriodicTask(
  //     everyTwoHoursTaskName,
  //     everyTwoHoursTaskName,
  //     frequency: const Duration(hours: 2),
  //     constraints: Constraints(networkType: NetworkType.connected),
  //     existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
  //   );
  // }

  ///  не более одной загрузки в сутки
  static Future<void> registerOnceToday() async {
    await Workmanager().registerPeriodicTask(
      onceTodayTaskName,
      onceTodayTaskName,
      frequency: const Duration(hours: 6),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }

  static Future<void> cancelAll() async {
    await Workmanager().cancelAll();
  }
}
