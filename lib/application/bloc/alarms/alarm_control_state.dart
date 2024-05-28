part of 'alarm_control_bloc.dart';

@immutable
sealed class AlarmControlState {}

final class AlarmControlInitial extends AlarmControlState {}

final class AlarmControlOpen extends AlarmControlState {}

final class AlarmControlAccepted extends AlarmControlState {}

final class AlarmControlRejected extends AlarmControlState {}

final class AlarmControlEmpty extends AlarmControlState {}

final class AlarmControlFailed extends AlarmControlState {}
