part of 'alarm_detail_bloc.dart';

@immutable
abstract class AlarmDetailEvent {}

final class AlarmDetailIdPressed extends AlarmDetailEvent {
  final int eventId;

  AlarmDetailIdPressed(this.eventId);
}
