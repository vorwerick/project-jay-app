import 'package:app/domain/entities/event.dart';
import 'package:app/domain/primitives/result.dart';

abstract interface class EventsStorageRepository {
  Future<Result<EventsStorageRepositoryErrors, List<Event>>> getAllEvents();

  Future<Result<EventsStorageRepositoryErrors, Event>> getEventById(String id);

  Future<Result<EventsStorageRepositoryErrors, Event>> getLastEvent();

  Future<void> addNewEvent(Event event);

  Future<void> updateEvent(Event event);

  Future<void> deleteEvent(String id);
}

sealed class EventsStorageRepositoryErrors {}

final class EventNotFound extends EventsStorageRepositoryErrors {}
