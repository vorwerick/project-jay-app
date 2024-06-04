import 'package:app/domain/alarm_event/alarm_event.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:app/infrastructure/utils/shared_prefs.dart';

final class SharedEventRepository with RepositoryStreamer<Event>, SharedPrefs implements EventsStorageRepository {
  static const String _eventIdKey = 'eventId';

  static const String _eventDateKey = 'eventDate';

  @override
  Future<Result<EventsStorageRepositoryStatus, void>> addNewEvent(final Event event) async {
    final prefs = await getPrefs();
    prefs.setInt(_eventIdKey, event.id);
    prefs.setString(_eventDateKey, event.time.toIso8601String());
    notifyListeners(event);
    return Result.success(null);
  }

  @override
  Future<Result<EventsStorageRepositoryStatus, void>> deleteEvent() async {
    final prefs = await getPrefs();
    prefs.remove(_eventIdKey);
    prefs.remove(_eventDateKey);
    return Result.success(null);
  }

  @override
  Future<Result<EventsStorageRepositoryStatus, Event>> getEvent() async {
    final prefs = await getPrefs();
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
