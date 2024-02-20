import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_strategy.dart';

final class AlarmFetchLast extends AlarmFetchTemplate {
  AlarmFetchLast(super.alarmRepository);

  @override
  Future<Alarm?> fetchAlarm() async {
    final result = await alarmRepository.getLast();

    if (result.isSuccess) {
      return result.success;
    }
    return null;
  }
}
