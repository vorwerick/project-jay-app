import 'dart:developer';

import 'package:app/application/services/event_service.dart';
import 'package:app/application/services/tts_service.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/event/repository/events_remote_repository.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:app/domain/user/repository/credential_storage.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:app/infrastructure/repositories/credentials_secure_storage.dart';
import 'package:app/infrastructure/repositories/mocked_alarm_repository.dart';
import 'package:app/infrastructure/repositories/mocked_events_remote_repository.dart';
import 'package:app/infrastructure/repositories/mocked_events_storage_repository.dart';
import 'package:app/infrastructure/repositories/mocked_setting_repository.dart';
import 'package:app/infrastructure/repositories/mocked_user_repository.dart';
import 'package:app/infrastructure/services/simple_event_service.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:get_it/get_it.dart';

// official package: https://pub.dev/packages/get_it
final class AppDependencyConfiguration {
  AppDependencyConfiguration._();

  static Future<void> init() async {
    log('Starting app dependency configuration', name: 'AppDependencyConfiguration');
    final GetIt getIt = GetIt.instance;

    // Repositories
    getIt.registerSingleton<UserRepository>(MockedUserRepository());
    getIt.registerSingleton<SettingRepository>(MockedSettingRepository());
    getIt.registerSingleton<AlarmRepository>(MockedAlarmRepository());
    getIt.registerSingleton<CredentialsStorage>(CredentialsSecureStorage());
    getIt.registerSingleton<EventsStorageRepository>(MockedEventsStorageRepository());
    getIt.registerSingleton<EventsRemoteRepository>(MockedEventsRemoteRepository());

    // Services
    getIt.registerSingleton<EventService>(
      SimpleEventService(
        getIt.get<EventsRemoteRepository>(),
        getIt.get<EventsStorageRepository>(),
      ),
    );

    getIt.registerSingleton<TTSService>(
      TextToSpeechService(
        getIt.get<SettingRepository>(),
      ),
    );
  }
}
