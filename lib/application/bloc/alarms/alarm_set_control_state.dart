part of 'alarm_set_control_bloc.dart';

@immutable
sealed class AlarmSetControlState {}

final class AlarmSetControlInit extends AlarmSetControlState {}

final class AlarmSetControlProcessing extends AlarmSetControlState {}

final class AlarmSetControlSuccess extends AlarmSetControlState {}

final class AlarmSetControlSkip extends AlarmSetControlState {}

final class AlarmSetControlFailed extends AlarmSetControlState {}
