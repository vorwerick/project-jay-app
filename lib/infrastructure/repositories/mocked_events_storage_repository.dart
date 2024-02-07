import 'dart:developer';

import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/domain/primitives/result.dart';

final class MockedEventsStorageRepository implements EventsStorageRepository {
  final List<Event> _events = [];

  MockedEventsStorageRepository() {
    _createMockedData();
  }

  @override
  Future<void> addNewEvent(final Event event) async {
    log('Adding new event: $event');
    _events.add(event);
  }

  @override
  Future<void> deleteEvent(final String id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Result<EventsStorageRepositoryFailure, List<Event>>> getAllEvents() async {
    log('Getting all events', name: 'MockedEventsStorageRepository');
    if (_events.isEmpty) {
      return Result.failure(EventsStorageRepositoryFailure.eventNotFound());
    } else {
      return Result.success(_events);
    }
  }

  @override
  Future<Result<EventsStorageRepositoryFailure, Event>> getEventById(final String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Result<EventsStorageRepositoryFailure, Event>> getLastEvent() async {
    log('Getting last event', name: 'MockedEventsStorageRepository');
    if (_events.isEmpty) {
      return Result.failure(EventsStorageRepositoryFailure.eventNotFound());
    } else {
      return Result.success(_events.last);
    }
  }

  @override
  Future<void> updateEvent(final Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

  void _createMockedData() {
    final DateTime now = DateTime.now();
    for (int i = 0; i < 10; i++) {
      _events.add(
        Event(
          i,
          DateTime(
            now.year,
            now.month,
            now.day,
            now.hour,
            now.minute,
            now.second + i,
          ),
        ),
      );
    }
  }
}
