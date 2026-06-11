import 'package:catimage/features/domain/repositories/cat_repository.dart';
import 'package:catimage/features/presentation/bloc/today/today_event.dart';
import 'package:catimage/features/presentation/bloc/today/today_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayBloc extends Bloc<TodayEvent, TodayState> {
  final CatRepository repository;

  TodayBloc({required this.repository}) : super(const TodayInitial()) {
    on<LoadCachedCatEvent>(_onLoadCached);
    on<FetchNewCatEvent>(_onFetchNew);
  }

  Future<void> _onLoadCached(
    LoadCachedCatEvent event,
    Emitter<TodayState> emit,
  ) async {
    final cached = await repository.getCachedCatImage();
    if (cached != null) {
      emit(TodayLoaded(cached));
    }
  }

  Future<void> _onFetchNew(
    FetchNewCatEvent event,
    Emitter<TodayState> emit,
  ) async {
    emit(const TodayLoading());
    final cat = await repository.fetchAndCacheCatImage();
    if (cat != null) {
      emit(TodayLoaded(cat));
    } else {
      emit(const TodayError('Не удалось загрузить изображение'));
    }
  }
}
