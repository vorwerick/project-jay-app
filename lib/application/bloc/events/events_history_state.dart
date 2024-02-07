part of 'events_history_bloc.dart';

@immutable
abstract class EventsHistoryState {}

class EventsHistoryInitial extends EventsHistoryState {}

final class LoadedEventsHistory extends EventsHistoryState with EquatableMixin {
  final List<EventDto> events;

  LoadedEventsHistory(this.events);

  @override
  List<Object?> get props => [events];
}
