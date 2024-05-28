import 'dart:developer';

import 'package:app/app.dart';
import 'package:app/application/services/alarm/alarm_notification_service.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/configuration/di/app_dependency_configuration.dart';
import 'package:app/configuration/navigation/routes_config.dart';
import 'package:app/presentation/utils/firebase_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(final RemoteMessage message) async {
  AppDependencyConfiguration.initBackground();

  Logger l = GetIt.I<Logger>();
  l.i('Got a message whilst in the background!');
  l.d('Message data: ${message.data.isEmpty ? 'empty' : message.data}');

  final title = message.data['text'] ?? 'Alarm';
  final body = message.data['preview'] ?? 'There is alarm alarm_event';

  GetIt.I<AlarmNotificationService>().showAlarm(title, body);
}

Future<void> _firebaseOnMessageHandler(final RemoteMessage message) async {
  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');
  Fluttertoast.showToast(msg: 'Message data: ${message.data}', gravity: ToastGravity.CENTER);
}

Future<void> _firebaseMessageHandler(final RemoteMessage message) async {
  log('A new was published!');
  log('Message data: ${message.data}');
  Fluttertoast.showToast(msg: 'Message data: ${message.data}', gravity: ToastGravity.CENTER);
}

Future<void> _initFirebase() async {
  await FirebaseUtils.initCore();
  await FirebaseUtils.requestNotificationPermission();
  await FirebaseUtils.showTokenToLog();

  FirebaseMessaging.onMessage.listen(_firebaseOnMessageHandler);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    log('Handling a initial message: ${initialMessage.messageId}');
    _firebaseMessageHandler(initialMessage);
  } else {
    log('No initial message');
  }

  FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessageHandler);

  FirebaseUtils.initCrashlytics();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppDependencyConfiguration.init();

  await _initFirebase();
  await GetIt.I<EventService>().startPolling();

  final routerConfig = await GetIt.I<RoutesConfig>().create();

  runApp(
    App(
      routerConfig: routerConfig,
    ),
  );
}
