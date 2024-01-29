part of 'alert_bloc.dart';

@immutable
abstract class AlertState extends Equatable {}

class AlertInitial extends AlertState {
  @override
  List<Object?> get props => [this];
}

class CurrentAlertsState extends AlertState {
  final List<AlertDto> alerts;

  CurrentAlertsState(this.alerts);

  @override
  List<Object?> get props => [alerts];
}
