import 'package:catimage/features/domain/entities/cat_entity.dart';

abstract class TodayState {
  const TodayState();
}

class TodayInitial extends TodayState {
  const TodayInitial();
}

class TodayLoading extends TodayState {
  const TodayLoading();
}

class TodayLoaded extends TodayState {
  final CatEntity cat;
  const TodayLoaded(this.cat);
}

class TodayError extends TodayState {
  final String message;
  const TodayError(this.message);
}
