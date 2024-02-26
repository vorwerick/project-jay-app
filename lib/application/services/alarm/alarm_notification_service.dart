abstract interface class AlarmNotificationService {
  Future<void> clearNotifications();

  Future<void> showAlarm(final String title, final String messageBody);
}
