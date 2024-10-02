part of 'alarm_gps_bloc.dart';

@immutable
abstract class AlarmGpsEvent {}

final class AlarmGpsStarted extends AlarmGpsEvent {

  final int eventId;

  AlarmGpsStarted({required this.eventId});
}
