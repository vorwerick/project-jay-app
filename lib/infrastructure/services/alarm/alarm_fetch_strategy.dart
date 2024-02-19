import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_by_id.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_last.dart';

abstract base class AlarmFetchTemplate {
  final AlarmRepository alarmRepository;

  AlarmFetchTemplate(this.alarmRepository);

  Future<Alarm?> fetchAlarm();

  factory AlarmFetchTemplate.byId(
    final int? id,
    final AlarmRepository alarmRepository,
  ) {
    if (id != null) {
      return AlarmFetchById(
        alarmRepository,
        id,
      );
    }
    return AlarmFetchLast(
      alarmRepository,
    );
  }
}
