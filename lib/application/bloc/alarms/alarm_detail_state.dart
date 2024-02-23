part of 'alarm_detail_bloc.dart';

@immutable
abstract class AlarmDetailState {}

class AlarmDetailInitial extends AlarmDetailState {}

class AlarmDetailLoadInProgress extends AlarmDetailState {}

class AlarmDetailLoadFailure extends AlarmDetailState {}

final class AlarmDetailLoadSuccess extends AlarmDetailState with EquatableMixin {
  final AlarmDto alarm;

  AlarmDetailLoadSuccess(this.alarm);

  @override
  List<Object?> get props => [alarm];
}
