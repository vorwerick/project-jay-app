import 'package:app/domain/entities/event.dart';
import 'package:app/domain/primitives/either.dart';
import 'package:app/domain/repositories/events_storage_repository.dart';

final class EventsHiveStorageRepository implements EventsStorageRepository {
  @override
  Future<void> addNewEvent(Event event) {
    // TODO: implement addNewEvent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEvent(String id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<EventsStorageRepositoryErrors, List<Event>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<EventsStorageRepositoryErrors, Event>> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Either<EventsStorageRepositoryErrors, Event>> getLastEvent() {
    // TODO: implement getLastEvent
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}
