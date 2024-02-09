import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/primitives/result.dart';

abstract interface class EventsRemoteRepository {
  Future<Result<EventsRemoteRepositoryFailure, Event>> getLastEventDescription();
}

sealed class EventsRemoteRepositoryFailure {}

final class EventsRemoteRepositoryException extends EventsRemoteRepositoryFailure {
  final Exception exception;

  EventsRemoteRepositoryException(this.exception);
}
