part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmEvent {}

final class ActiveAlarmStarted extends ActiveAlarmEvent {
  final bool enableLiveUpdate;

  ActiveAlarmStarted({this.enableLiveUpdate = false});
}

final class ActiveAlarmSilentRefresh extends ActiveAlarmEvent {

}
