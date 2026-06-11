import 'package:catimage/features/domain/entities/cat_entity.dart';

abstract class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoaded extends HistoryState {
  final List<CatEntity> items;
  const HistoryLoaded(this.items);
}
