import 'package:app/application/commands/command.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';

final class HasActiveEventAsync implements AsyncCommand<bool> {
  final AlarmRepository _repository;

  HasActiveEventAsync(this._repository);

  @override
  Future<bool> execute() async {
    final result = await _repository.hasActiveAlarm();

    if (result.isSuccess) {
      return result.success;
    }
    return false;
  }
}
