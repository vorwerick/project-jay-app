import 'package:equatable/equatable.dart';

final class AlertDto extends Equatable {
  final String unitName;
  final String role;

  final bool hasActiveAlarm;

  const AlertDto({required this.unitName, required this.role, required this.hasActiveAlarm});

  @override
  List<Object?> get props => [unitName, role, hasActiveAlarm];
}
