import 'dart:developer';
import 'dart:io';

import 'package:app/app.dart';
import 'package:app/configuration/di/app_dependency_configuration.dart';
import 'package:app/domain/alarm/repository/confirmation_repository.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const ONE_SIGNAL_APP_ID = 'c1742112-083d-469c-adf1-6614fa33d5f6';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  OneSignal.initialize(ONE_SIGNAL_APP_ID);

  await OneSignal.Notifications.requestPermission(true);
  if (kDebugMode) {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }

  AppDependencyConfiguration.init();

  await SentryFlutter.init(
    (final options) {
      options.dsn =
          'https://bb64b5286c9ae21975fc4531a996d24e@o1174084.ingest.us.sentry.io/4507985639243776';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      const App(),
    ),
  );

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    log('onFORE');
    log(event.notification.title.toString());
  });
  OneSignal.Notifications.addClickListener((final event) async {
    final prefs = await SharedPreferences.getInstance();
    StringBuffer sb = StringBuffer();
    String g = prefs.getString('notifications') ?? '';
    sb.write(g);
    sb.write('\n');
    sb.write(
        '${DateTime.now().toString()} priority: ${event.notification.priority}');

    prefs.setString('notifications', sb.toString());
    log('NOTOTOT');
    log(event.notification.body.toString());
    log(event.notification.additionalData.toString());
    log(event.notification.rawPayload.toString());
    final int eventId = event.notification.additionalData!['eventId'];
    log('EVENTUS: ' + eventId.toString());
    final confirmationRepository = GetIt.I.get<ConfirmationRepository>();
    if (event.result.actionId == 'accept') {
      await confirmationRepository.confirm(eventId);
    } else if (event.result.actionId == 'decline') {
      await confirmationRepository.reject(eventId);
    }
  });
}
