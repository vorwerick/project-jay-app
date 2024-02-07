import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/domain/primitives/result.dart';

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
  Future<Result<EventsStorageRepositoryFailure, List<Event>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Result<EventsStorageRepositoryFailure, Event>> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Result<EventsStorageRepositoryFailure, Event>> getLastEvent() {
    // TODO: implement getLastEvent
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}
