part of 'event_detail_bloc.dart';

@immutable
abstract class EventDetailEvent {}

final class EventDetailIdPressed extends EventDetailEvent {
  final int eventId;

  EventDetailIdPressed(this.eventId);
}

final class EventDetailActiveRequested extends EventDetailEvent {}
