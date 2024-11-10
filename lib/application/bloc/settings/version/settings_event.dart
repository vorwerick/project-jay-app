part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

final class SettingsStarted extends SettingsEvent {}

final class SettingsEnableTTSPressed extends SettingsEvent {
  final bool enable;

  SettingsEnableTTSPressed(this.enable);
}

final class SettingsSetNotificationSound extends SettingsEvent {
  final String sound;

  SettingsSetNotificationSound({required this.sound});
}

final class SettingsSetMap extends SettingsEvent {
  final String map;

  SettingsSetMap({required this.map});
}

final class SettingsSetActiveAlarmDuration extends SettingsEvent {
  final int minutes;

  SettingsSetActiveAlarmDuration({required this.minutes});
}
