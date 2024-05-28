import 'dart:developer';

import 'package:app/application/services/alarm/alarm_notification_service.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/application/services/tts_service.dart';
import 'package:app/application/shared/device_information.dart';
import 'package:app/application/shared/device_information_factory.dart';
import 'package:app/configuration/navigation/routes_config.dart';
import 'package:app/domain/alerts/alert.dart';
import 'package:app/domain/domain_repositories.dart';
import 'package:app/infrastructure/api_v1/repositories/jay_api_v1_repositories.dart';
import 'package:app/infrastructure/repositories/credentials_secure_storage.dart';
import 'package:app/infrastructure/repositories/shared_event_repository.dart';
import 'package:app/infrastructure/repositories/shared_setting_repository.dart';
import 'package:app/infrastructure/services/alarm/simple_alarm_service.dart';
import 'package:app/infrastructure/services/notification/firebase_alarm_notification_service.dart';
import 'package:app/infrastructure/services/simple_event_service.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/infrastructure/shared/info_plus_device_information_factory.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// official package: https://pub.dev/packages/get_it
/// Before running init, please ensure call of WidgetsFlutterBinding.ensureInitialized();

final class AppDependencyConfiguration {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      printTime: true,
    ),
  );

  AppDependencyConfiguration._();

  static Future<void> init() async {
    log('Starting app dependency configuration', name: 'AppDependencyConfiguration');
    final GetIt getIt = GetIt.instance;

    getIt.registerSingleton<Logger>(_logger);

    // Factories
    getIt.registerSingleton<DeviceInformationFactory>(InfoPlusDeviceInformationFactory());
    getIt.registerFactoryAsync<DeviceInformation>(
      () => getIt.get<DeviceInformationFactory>().createDeviceInformation(),
    );

    // Repositories
    getIt.registerSingleton<UserRepository>(JayApiV1UserRepository());
    getIt.registerSingleton<SettingRepository>(SharedSettingRepository());
    getIt.registerSingleton<AlarmRepository>(JayApiV1AlarmRepository());
    getIt.registerSingleton<CredentialsStorage>(CredentialsSecureStorage());
    getIt.registerSingleton<EventsStorageRepository>(SharedEventRepository());
    getIt.registerSingleton<DeviceRegistrationRepository>(JayApiV1RegistrationRepository());
    getIt.registerSingleton<MemberRepository>(JayApiV1MemberRepository());
    getIt.registerSingleton<ConfirmationRepository>(JayApiV1ConfirmationRepository());

    // Aggregates
    getIt.registerSingleton<Alert>(
      Alert(
        getIt.get<ConfirmationRepository>(),
        getIt.get<EventsStorageRepository>(),
      ),
    );

    // Services
    getIt.registerSingleton<AlarmService>(
      SimpleAlarmService(
        getIt.get<AlarmRepository>(),
        getIt.get<EventsStorageRepository>(),
      ),
    );
    getIt.registerSingleton<EventService>(
      SimpleEventService(
        getIt<AlarmRepository>(),
        getIt<Alert>(),
      ),
    );

    getIt.registerSingleton<TTSService>(
      TextToSpeechService(
        getIt.get<SettingRepository>(),
      ),
    );

    getIt.registerLazySingleton<AlarmNotificationService>(
      () => FirebaseAlarmNotificationService(),
    );

    // Routing
    getIt.registerSingleton(RoutesConfig(getIt<EventService>()));
  }

  static void initBackground() {
    _logger.d('Starting background dependency configuration');
    final GetIt getIt = GetIt.I;

    if (!getIt.isRegistered<AlarmNotificationService>()) {
      getIt.registerLazySingleton<AlarmNotificationService>(() => FirebaseAlarmNotificationService());
    }

    if (!GetIt.I.isRegistered<Logger>()) {
      GetIt.I.registerSingleton<Logger>(_logger);
    }
  }
}
