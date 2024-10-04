part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmState {}

class ActiveAlarmInitial extends ActiveAlarmState {}

final class ActiveAlarmFailure extends ActiveAlarmState {}

final class ActiveAlarmLoadInProgress extends ActiveAlarmState {}

final class ActiveAlarmLoadSuccess extends ActiveAlarmState with EquatableMixin {
  final List<AlarmDto> alarms;

  ActiveAlarmLoadSuccess(this.alarms);

  @override
  List<Object?> get props => [alarms];

  @override
  bool? get stringify => true;
}
