import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_notification_service.dart';
import 'package:app/configuration/di/app_dependency_configuration.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final class FirebaseAlarmNotificationService with L implements AlarmNotificationService {
  static const _alarmId = 666;
  static const actionAcceptId = 'accept_id';
  static const actionDeclineId = 'decline_id';

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    enableVibration: true,

    sound: RawResourceAndroidNotificationSound('fire_siren.wav'),
  );

  static const AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> clearNotifications() => _localNotificationsPlugin.cancelAll();

  @override
  Future<void> showAlarm(final String title, final String messageBody) async {
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          _channel,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    _localNotificationsPlugin.show(
      _alarmId,
      title,
      messageBody,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id, _channel.name,
          channelDescription: _channel.description,

          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              actionAcceptId,
              'Přijmout',
              titleColor: JayColors.secondary,
            ),
            const AndroidNotificationAction(
              actionDeclineId,
              'Odmítnout',
              titleColor: JayColors.secondary,
            ),
          ],
          // other properties...
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(final NotificationResponse notificationResponse) {
    AppDependencyConfiguration.initBackground();
    final l = GetIt.I<Logger>();
    if (notificationResponse.actionId == null) {
      l.w('ActionId is empty');
      return;
    }
    // TODO(Vojjta): Implement the action handling
    switch (notificationResponse.actionId) {
      case FirebaseAlarmNotificationService.actionAcceptId:
        l.i('User accepted the alarm');
        break;
      case FirebaseAlarmNotificationService.actionDeclineId:
        l.i('User declined the alarm');
        break;
      default:
        l.d('User tapped the notification with no action');
    }
  }
}
