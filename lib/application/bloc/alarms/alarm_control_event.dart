part of 'alarm_control_bloc.dart';

@immutable
sealed class AlarmControlEvent {}

final class AlarmControlStarted extends AlarmControlEvent {}

final class AlarmControlEventReceived extends AlarmControlEvent {
  final AlarmEvents event;

  AlarmControlEventReceived(this.event);
}

final class AlarmControlAcceptPressed extends AlarmControlEvent {}

final class AlarmControlRejectPressed extends AlarmControlEvent {}

final class AlarmControlDelayPressed extends AlarmControlEvent {}
