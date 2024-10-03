part of 'alarm_control_bloc.dart';

@immutable
sealed class AlarmControlState {}

final class AlarmControlStateLoad extends AlarmControlState {}

final class AlarmControlStateLoading extends AlarmControlState {}

final class AlarmControlStateSuccessAccepted extends AlarmControlState {}

final class AlarmControlStateSuccessNone extends AlarmControlState {}

final class AlarmControlStateSuccessRejected extends AlarmControlState {}

final class AlarmControlStateFailed extends AlarmControlState {}
