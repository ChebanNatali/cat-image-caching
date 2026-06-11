import 'package:catimage/features/domain/repositories/cat_repository.dart';
import 'package:catimage/features/presentation/bloc/history/history_event.dart';
import 'package:catimage/features/presentation/bloc/history/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final CatRepository repository;

  HistoryBloc({required this.repository}) : super(const HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistory);
  }

  Future<void> _onLoadHistory(
    LoadHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final items = await repository.getHistory();
    emit(HistoryLoaded(items));
  }
}
