part of 'alarm_gps_bloc.dart';

@immutable
abstract class AlarmGpsState {}

class AlarmGpsInitial extends AlarmGpsState {}

final class AlarmGpsLoadInProgress extends AlarmGpsState {}

final class AlarmGpsLoadFailure extends AlarmGpsState {}

final class AlarmGpsLoadSuccess extends AlarmGpsState with EquatableMixin {
  final double latitude;

  final double longitude;

  AlarmGpsLoadSuccess(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  bool? get stringify => true;
}
