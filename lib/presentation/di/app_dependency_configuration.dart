import 'dart:developer';

import 'package:app/domain/repositories/alarm_repository.dart';
import 'package:app/domain/repositories/credential_storage.dart';
import 'package:app/domain/repositories/events_storage_repository.dart';
import 'package:app/domain/repositories/setting_repository.dart';
import 'package:app/domain/repositories/user_repository.dart';
import 'package:app/infrastructure/repositories/combined_setting_repository.dart';
import 'package:app/infrastructure/repositories/credentials_secure_storage.dart';
import 'package:app/infrastructure/repositories/events_hive_storage_repository.dart';
import 'package:app/infrastructure/repositories/mocked_alarm_repository.dart';
import 'package:app/infrastructure/repositories/mocked_user_repository.dart';
import 'package:get_it/get_it.dart';

// official package: https://pub.dev/packages/get_it
final class AppDependencyConfiguration {
  AppDependencyConfiguration._();

  static Future<void> init() async {
    log('Starting app dependency configuration', name: 'AppDependencyConfiguration');
    final GetIt getIt = GetIt.instance;

    getIt.registerSingleton<UserRepository>(MockedUserRepository());
    getIt.registerSingleton<SettingRepository>(CombinedSettingRepository());
    getIt.registerSingleton<AlarmRepository>(MockedAlarmRepository());
    getIt.registerSingleton<CredentialsStorage>(CredentialsSecureStorage());
    getIt.registerSingleton<EventsStorageRepository>(EventsHiveStorageRepository());
  }
}
