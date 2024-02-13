part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoadInProgress extends SettingsState {}

class SettingsLoadSuccess extends SettingsState with EquatableMixin {
  final String version;

  final bool isTttEnabled;

  SettingsLoadSuccess(this.version, this.isTttEnabled);

  @override
  List<Object?> get props => [version, isTttEnabled];

  @override
  bool? get stringify => true;
}
