part of 'alert_bloc.dart';

@immutable
abstract class AlertEvent {}

final class GetAlertsEvent extends AlertEvent {}
