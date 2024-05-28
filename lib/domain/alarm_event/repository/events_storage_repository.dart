import 'package:app/domain/alarm_event/entity/event.dart';
import 'package:app/domain/common/result.dart';

abstract interface class EventsStorageRepository {
  Stream<Event> get stream;

  Future<Result<EventsStorageRepositoryStatus, Event>> getEvent();

  Future<Result<EventsStorageRepositoryStatus, void>> addNewEvent(final Event event);

  Future<Result<EventsStorageRepositoryStatus, void>> updateEvent(final Event event);

  Future<Result<EventsStorageRepositoryStatus, void>> deleteEvent();
}

sealed class EventsStorageRepositoryStatus {
  const EventsStorageRepositoryStatus();

  factory EventsStorageRepositoryStatus.fromException(final Exception exception) =>
      EventsStorageRepositoryError(exception);

  factory EventsStorageRepositoryStatus.eventNotFound() => EventNotFound();
}

final class EventNotFound extends EventsStorageRepositoryStatus {}

final class EventsStorageRepositoryError extends EventsStorageRepositoryStatus {
  final Exception exception;

  EventsStorageRepositoryError(this.exception);
}
