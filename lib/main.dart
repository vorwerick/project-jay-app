import 'dart:developer';

import 'package:app/presentation/utils/firebase_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'presentation/navigation/routes.dart';

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

  await _initFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //TODO(Vojjta): create proper theme
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC02222),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC02222),
          inversePrimary: Color(0xFFA83434),
          onPrimary: Colors.white,
          secondary: Colors.white,
          background: Color(0xFF4b4a4a),
          onBackground: Colors.white,
          tertiary: Colors.deepPurple,
          surface: Color(0xFFA83434),
          onSurface: Colors.black,
          surfaceVariant: Colors.white,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('cs'),
      ],
      builder: (context, child) {
        return Material(
          child: child,
        );
      },
      routerConfig: Routes.create(),
    );
  }
}
