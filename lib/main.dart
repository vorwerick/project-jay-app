import 'dart:developer';

import 'package:app/app.dart';
import 'package:app/presentation/di/app_dependency_configuration.dart';
import 'package:app/presentation/navigation/routes_config.dart';
import 'package:app/presentation/utils/firebase_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Got a message whilst in the background!');
  log("Message data: ${message.data}");
}

Future<void> _firebaseOnMessageHandler(RemoteMessage message) async {
  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');
  Fluttertoast.showToast(msg: "Message data: ${message.data}", gravity: ToastGravity.CENTER);
}

Future<void> _firebaseMessageHandler(RemoteMessage message) async {
  log('A new was published!');
  log('Message data: ${message.data}');
  Fluttertoast.showToast(msg: "Message data: ${message.data}", gravity: ToastGravity.CENTER);
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
  final routerConfig = await RoutesConfig.create();

  runApp(App(
    routerConfig: routerConfig,
  ));
}
