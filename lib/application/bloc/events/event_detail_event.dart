part of 'event_detail_bloc.dart';

@immutable
abstract class EventDetailEvent {}

final class LoadDetailEvent extends EventDetailEvent {
  final int eventId;

  LoadDetailEvent(this.eventId);
}

final class LoadActiveEvent extends EventDetailEvent {}
