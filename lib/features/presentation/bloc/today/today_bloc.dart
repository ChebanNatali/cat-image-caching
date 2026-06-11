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
    final lastCachedImage = await repository.getCachedCatImage();

    if (lastCachedImage != null &&
        lastCachedImage.downloadedAt != null &&
        _isToday(lastCachedImage.downloadedAt!)) {
      emit(TodayLoaded(lastCachedImage));
    } else {
      add(const FetchNewCatEvent());
    }
  }

  Future<void> _onFetchNew(
    FetchNewCatEvent event,
    Emitter<TodayState> emit,
  ) async {
    emit(const TodayLoading());
    final catImage = await repository.fetchAndCacheCatImage();
    if (catImage != null) {
      emit(TodayLoaded(catImage));
    } else {
      emit(const TodayError('Не удалось загрузить изображение'));
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
