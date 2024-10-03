part of 'alarm_set_control_bloc.dart';

@immutable
sealed class AlarmSetControlEvent {}

final class AlarmSetControlIdle extends AlarmSetControlEvent {

  AlarmSetControlIdle();
}

final class AlarmSetControlAcceptPressed extends AlarmSetControlEvent {
  final int eventId;

  AlarmSetControlAcceptPressed({required this.eventId});
}

final class AlarmSetControlRejectPressed extends AlarmSetControlEvent {
  final int eventId;

  AlarmSetControlRejectPressed({required this.eventId});
}

//final class AlarmControlDelayPressed extends AlarmControlEvent {}
