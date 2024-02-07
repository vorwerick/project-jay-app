part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmState {}

class ActiveAlarmInitial extends ActiveAlarmState {}

final class ActiveAlarmFailure extends ActiveAlarmState {}

final class ActiveAlarmSuccess extends ActiveAlarmState {}
