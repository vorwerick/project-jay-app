part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmEvent {}

final class ActiveAlarmStarted extends ActiveAlarmEvent {
  final bool enableLiveUpdate;

  ActiveAlarmStarted({this.enableLiveUpdate = false});
}

final class ActiveAlarmRefreshed extends ActiveAlarmEvent {
  final Alarm alarm;

  ActiveAlarmRefreshed(this.alarm);
}
