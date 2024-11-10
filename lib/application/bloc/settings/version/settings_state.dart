part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoadInProgress extends SettingsState {}

class SettingsLoadSuccess extends SettingsState with EquatableMixin {
  final bool isTttEnabled;
  final String notificationSound;
  final String map;
  final int activeAlarmDuration;

  SettingsLoadSuccess(
    this.isTttEnabled,
    this.notificationSound,
    this.activeAlarmDuration,
    this.map,
  );

  @override
  List<Object?> get props =>
      [isTttEnabled, notificationSound, activeAlarmDuration,map];

  @override
  bool? get stringify => true;
}
