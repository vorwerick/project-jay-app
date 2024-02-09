import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/primitives/result.dart';

abstract interface class EventsStorageRepository {
  Future<Result<EventsStorageRepositoryFailure, List<Event>>> getAllEvents();

  Future<Result<EventsStorageRepositoryFailure, Event>> getEventById(final String id);

  Future<Result<EventsStorageRepositoryFailure, Event>> getLastEvent();

  Future<void> addNewEvent(final Event event);

  Future<void> updateEvent(final Event event);

  Future<void> deleteEvent(final String id);
}

sealed class EventsStorageRepositoryFailure {
  const EventsStorageRepositoryFailure();

  factory EventsStorageRepositoryFailure.fromException(final Exception exception) =>
      EventsStorageRepositoryError(exception);

  factory EventsStorageRepositoryFailure.eventNotFound() => EventNotFound();
}

final class EventNotFound extends EventsStorageRepositoryFailure {}

final class EventsStorageRepositoryError extends EventsStorageRepositoryFailure {
  final Exception exception;

  EventsStorageRepositoryError(this.exception);
}
