part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmState {}

class ActiveAlarmInitial extends ActiveAlarmState {}

final class ActiveAlarmFailure extends ActiveAlarmState {}

final class ActiveAlarmLoadInProgress extends ActiveAlarmState {}

final class ActiveAlarmLoadSuccess extends ActiveAlarmState with EquatableMixin {
  final AlarmDto alarm;

  ActiveAlarmLoadSuccess(this.alarm);

  @override
  List<Object?> get props => [alarm];

  @override
  bool? get stringify => true;
}
