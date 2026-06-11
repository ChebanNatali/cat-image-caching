import 'package:catimage/core/utils/local_store.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton(LocalStorage());
}
