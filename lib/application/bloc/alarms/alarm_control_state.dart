part of 'alarm_control_bloc.dart';

@immutable
sealed class AlarmControlState {}

final class AlarmControlStateLoad extends AlarmControlState {}

final class AlarmControlStateLoading extends AlarmControlState {}

final class AlarmControlStateSuccessAccepted extends AlarmControlState {}

final class AlarmControlStateSuccessNoneMaximized extends AlarmControlState {}

final class AlarmControlStateSuccessNoneMinimized extends AlarmControlState {}

final class AlarmControlStateSuccessRejected extends AlarmControlState {}

final class AlarmControlStateFailed extends AlarmControlState {}
