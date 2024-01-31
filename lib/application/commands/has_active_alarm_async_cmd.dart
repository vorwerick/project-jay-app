import 'package:app/application/commands/command.dart';
import 'package:app/domain/repositories/alarm_repository.dart';

final class HasActiveAlarmAsyncCommand implements AsyncCommand<bool> {
  final AlarmRepository _alarmRepository;

  HasActiveAlarmAsyncCommand(this._alarmRepository);

  @override
  Future<bool> execute() async {
    final result = await _alarmRepository.hasActiveAlarm();

    if (result.isSuccess && result.success) {
      return result.success;
    }

    return false;
  }
}
