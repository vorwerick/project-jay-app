part of 'alarm_control_bloc.dart';

@immutable
sealed class AlarmControlEvent {}

final class AlarmControlEdit extends AlarmControlEvent{

}

final class AlarmControlMinimize extends AlarmControlEvent{

}
final class AlarmControlGetStateStarted extends AlarmControlEvent {
  final int eventId;
  final int memberId;

  AlarmControlGetStateStarted({
    required this.eventId,
    required this.memberId,
  });
}
