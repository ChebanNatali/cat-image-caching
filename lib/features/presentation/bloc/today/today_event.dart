abstract class TodayEvent {
  const TodayEvent();
}

class LoadCachedCatEvent extends TodayEvent {
  const LoadCachedCatEvent();
}

class FetchNewCatEvent extends TodayEvent {
  const FetchNewCatEvent();
}
