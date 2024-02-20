import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedEventRepository with RepositoryStreamer<Event> implements EventsStorageRepository {
  static const String _eventIdKey = 'eventId';

  static const String _eventDateKey = 'eventDate';

  @override
  Future<Result<EventsStorageRepositoryStatus, void>> addNewEvent(final Event event) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_eventIdKey, event.id);
    prefs.setString(_eventDateKey, event.time.toIso8601String());
    notifyListeners(event);
    return Result.success(null);
  }

  @override
  Future<Result<EventsStorageRepositoryStatus, void>> deleteEvent(final String id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Result<EventsStorageRepositoryStatus, Event>> getEvent() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt(_eventIdKey);
    if (id == null) {
      return Result.failure(EventNotFound());
    }
    final String? date = prefs.getString(_eventDateKey);

    return Result.success(Event(id, DateTime.parse(date!)));
  }

  @override
  Future<Result<EventsStorageRepositoryStatus, void>> updateEvent(final Event event) => addNewEvent(event);
}
