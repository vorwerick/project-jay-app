import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final class FirebaseUtils {
  FirebaseUtils._();

  static Future<void> initCore() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void initCrashlytics() {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (final error, final stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// Permission to display notifications are necessary for iOS
  static Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    GetIt.I<Logger>().d('User granted permission: ${settings.authorizationStatus}');
  }

  static Future<void> showTokenToLog() async {
    if (kDebugMode) {
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      GetIt.I<Logger>().d('Firebase cloud messaging token: ${fcmToken ?? 'null'}');
    }
  }
}
