part of 'active_alarm_bloc.dart';

@immutable
abstract class ActiveAlarmState extends Equatable {}

class ActiveAlarmInitial extends ActiveAlarmState {
  @override
  List<Object?> get props => [this];
}

final class HasActiveAlarmState extends ActiveAlarmState {
  final int id;

  HasActiveAlarmState(this.id);

  @override
  List<Object?> get props => [id];
}
