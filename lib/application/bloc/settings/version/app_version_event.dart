part of 'app_version_bloc.dart';

@immutable
abstract class AppVersionEvent {}

final class AppVersionStarted extends AppVersionEvent {}
