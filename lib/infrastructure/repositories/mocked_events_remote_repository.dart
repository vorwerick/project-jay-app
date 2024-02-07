import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_remote_repository.dart';
import 'package:app/domain/primitives/result.dart';

final class MockedEventsRemoteRepository implements EventsRemoteRepository {
  @override
  Future<Result<EventsRemoteRepositoryFailure, Event>> getLastEventDescription() async =>
      Result.success(Event(1, DateTime.now()));
}
