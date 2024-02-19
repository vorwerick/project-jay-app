part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoadInProgress extends SettingsState {}

class SettingsLoadSuccess extends SettingsState with EquatableMixin {
  final bool isTttEnabled;

  SettingsLoadSuccess(this.isTttEnabled);

  @override
  List<Object?> get props => [isTttEnabled];

  @override
  bool? get stringify => true;
}
