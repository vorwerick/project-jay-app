import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_strategy.dart';

final class AlarmFetchById extends AlarmFetchTemplate {
  final int _id;

  AlarmFetchById(super.alarmRepository, this._id);

  @override
  Future<Alarm?> fetchAlarm() async {
    final result = await alarmRepository.getById(_id);
    if (result.isSuccess) {
      return result.success;
    }

    return null;
  }
}
