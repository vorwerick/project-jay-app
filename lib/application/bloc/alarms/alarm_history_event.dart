part of '../alarms/alarm_history_bloc.dart';

@immutable
abstract class AlarmHistoryEvent {}

final class AlarmHistoryStarted extends AlarmHistoryEvent {}
