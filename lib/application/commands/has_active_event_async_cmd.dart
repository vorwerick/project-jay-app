import 'package:app/application/commands/command.dart';
import 'package:app/domain/alarm_event/alarm_event.dart';

final class HasActiveEventAsync implements AsyncCommand<bool> {
  final EventsStorageRepository _repository;

  HasActiveEventAsync(this._repository);

  @override
  Future<bool> execute() async {
    final result = await _repository.getEvent();

    if (result.isSuccess && result.success.isValid) {
      return true;
    }
    return false;
  }
}
