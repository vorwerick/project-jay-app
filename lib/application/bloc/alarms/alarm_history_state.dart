part of '../alarms/alarm_history_bloc.dart';

@immutable
abstract class AlarmHistoryState {}

class AlarmHistoryInitial extends AlarmHistoryState {}

class AlarmHistoryLoadInProgress extends AlarmHistoryState {}

class AlarmHistoryLoadFailure extends AlarmHistoryState {}

final class AlarmHistoryLoadSuccess extends AlarmHistoryState with EquatableMixin {
  final List<EventDto> events;

  AlarmHistoryLoadSuccess(this.events);

  @override
  List<Object?> get props => [events];
}
