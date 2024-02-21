import 'package:app/application/commands/command.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';

final class HasActiveEventAsync implements AsyncCommand<bool> {
  final EventsStorageRepository _repository;

  HasActiveEventAsync(this._repository);

  @override
  Future<bool> execute() async {
    final result = await _repository.getEvent();

    if (result.isSuccess) {
      return true;
    }
    return false;
  }
}
