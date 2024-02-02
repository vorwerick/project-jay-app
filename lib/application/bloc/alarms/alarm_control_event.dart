part of 'alarm_control_bloc.dart';

@immutable
abstract class AlarmControlEvent {}

final class AlarmControlAcceptPressed extends AlarmControlEvent {}

final class AlarmControlRejectPressed extends AlarmControlEvent {}

final class AlarmControlDelayPressed extends AlarmControlEvent {}
