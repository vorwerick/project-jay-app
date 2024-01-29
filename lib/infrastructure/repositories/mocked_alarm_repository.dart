import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/repositories/alarm_repository.dart';

final class MockedAlarmRepository implements AlarmRepository {
  @override
  Future<Result<AlarmRepositoryState, bool>> hasActiveAlarm() async => Result.success(true);
}
