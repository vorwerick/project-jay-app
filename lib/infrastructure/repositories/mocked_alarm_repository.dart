import 'dart:developer';

import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/primitives/result.dart';

final class MockedAlarmRepository implements AlarmRepository {
  @override
  Future<Result<AlarmRepositoryState, bool>> hasActiveAlarm() async {
    const bool hasActiveAlarm = false;
    log(
      'Alarm is active: $hasActiveAlarm',
      name: 'MockedAlarmRepository',
    );
    return Result.success(hasActiveAlarm);
  }
}
