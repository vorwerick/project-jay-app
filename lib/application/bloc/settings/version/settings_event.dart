part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

final class SettingsStarted extends SettingsEvent {}

final class SettingsEnableTTSPressed extends SettingsEvent {
  final bool enable;

  SettingsEnableTTSPressed(this.enable);
}
