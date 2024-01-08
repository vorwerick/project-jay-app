import 'package:app/domain/entities/event.dart';
import 'package:app/domain/primitives/either.dart';

abstract interface class EventsStorageRepository {
  Future<Either<EventsStorageRepositoryErrors, List<Event>>> getAllEvents();

  Future<Either<EventsStorageRepositoryErrors, Event>> getEventById(String id);

  Future<Either<EventsStorageRepositoryErrors, Event>> getLastEvent();

  Future<void> addNewEvent(Event event);

  Future<void> updateEvent(Event event);

  Future<void> deleteEvent(String id);
}

sealed class EventsStorageRepositoryErrors {}

final class EventNotFound extends EventsStorageRepositoryErrors {}
