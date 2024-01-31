part of 'events_history_bloc.dart';

@immutable
abstract class EventsHistoryState extends Equatable {}

class EventsHistoryInitial extends EventsHistoryState {
  @override
  List<Object?> get props => [this];
}

final class LoadedEventsHistory extends EventsHistoryState {
  final List<EventDto> events;

  LoadedEventsHistory(this.events);

  @override
  List<Object?> get props => [events];
}
