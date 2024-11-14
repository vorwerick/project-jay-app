import 'package:app/domain/common/entity.dart';

final class Setting extends Entity {
  // final AppVersion appVersion;

  final bool isTTSEnabled;

  final bool isRegistered;

  final String notificationSound;

  final int activeAlarmDuration;

  final String map;

  final int? gameTimeResult;

  Setting._(
    super.id,
    this.isTTSEnabled,
    this.isRegistered,
    this.notificationSound,
    this.activeAlarmDuration,
    this.map,
    this.gameTimeResult,
  );

  factory Setting.createNew(
    final String notificationSound,
    final String map,
    final int activeAlarmDuration,
    final bool isTTSEnabled,
    final bool isRegistered,
    final int? gameTimeResult,
  ) =>
      Setting._(
        1,
        isTTSEnabled,
        isRegistered,
        notificationSound,
        activeAlarmDuration,
        map,
        gameTimeResult,
      );
}
