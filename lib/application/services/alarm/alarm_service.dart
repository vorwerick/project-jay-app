import 'package:app/domain/alarm/entity/alarm.dart';

abstract interface class AlarmService {
  Stream<Alarm> get stream;

  void startPolling();

  void stopPolling();

  void dispose();
}
