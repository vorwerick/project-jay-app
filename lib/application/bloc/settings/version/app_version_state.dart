part of 'app_version_bloc.dart';

@immutable
abstract class AppVersionState extends Equatable {}

class AppVersionInitial extends AppVersionState {
  @override
  List<Object?> get props => [this];
}

final class LoadedAppVersionState extends AppVersionState {
  final String appVersion;

  LoadedAppVersionState(this.appVersion);

  @override
  List<Object?> get props => [appVersion];
}
