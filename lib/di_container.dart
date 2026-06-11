import 'package:catimage/core/utils/local_store.dart';
import 'package:catimage/features/data/datasources/cat_remote_datasource.dart';
import 'package:catimage/features/data/repositories/cat_repository_impl.dart';
import 'package:catimage/features/domain/repositories/cat_repository.dart';
import 'package:catimage/features/presentation/bloc/history/history_bloc.dart';
import 'package:catimage/features/presentation/bloc/today/today_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton(LocalStorage());
  getIt.registerSingleton(http.Client());
  getIt.registerSingleton(CatRemoteDatasource(client: getIt()));
  getIt.registerSingleton<CatRepository>(
    CatRepositoryImpl(remoteDatasource: getIt(), localStorage: getIt()),
  );
  getIt.registerFactory(() => TodayBloc(repository: getIt()));
  getIt.registerFactory(() => HistoryBloc(repository: getIt()));
}
