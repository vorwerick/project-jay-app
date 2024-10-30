part of 'app_version_bloc.dart';

@immutable
abstract class AppVersionState {}

class AppVersionInitial extends AppVersionState {}

final class AppVersionLoadSuccess extends AppVersionState with EquatableMixin {
  final String appVersion;
  final int buildNumber;

  AppVersionLoadSuccess(this.appVersion, this.buildNumber);

  @override
  List<Object?> get props => [appVersion];

  @override
  bool? get stringify => true;
}
