import 'dart:developer';

import 'package:app/application/services/event_service.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:app/infrastructure/utils/service_pooling.dart';

final class SimpleEventService with RepositoryStreamer<bool>, ServicePooling implements EventService {
  int _eventId = -1;

  final EventsStorageRepository _eventRepository;

  final AlarmRepository _alarmRepository;

  SimpleEventService(this._eventRepository, this._alarmRepository);

  @override
  void dispose() {
    stop();
  }

  @override
  Future<void> startPolling() async {
    await _onPoolTime();
    start(_onPoolTime);
  }

  @override
  void stopPolling() => stop;

  Future<void> _onPoolTime() async {
    final result = await _alarmRepository.getActiveAlarm();

    if (result.isFailure && result.failure is AlarmNotFound) {
      await _eventRepository.deleteEvent();
      log('No active alarm', name: 'SimpleEventService');
      int newEventId = -1;
      if (newEventId != _eventId) {
        _eventId = newEventId;
        notifyListeners(false);
      }
      return;
    }

    if (result.isFailure) {
      log('Failure with active alarm', name: 'SimpleEventService');
      return;
    }

    final newEventId = result.success.id;
    log('checking event id: $newEventId', name: 'SimpleEventService');
    if (_eventId != newEventId) {
      _eventId = newEventId;
      _eventRepository.addNewEvent(Event(_eventId, result.success.lastUpdate));
      notifyListeners(true);
    }
  }
}
