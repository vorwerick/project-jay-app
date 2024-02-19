import 'dart:async';
import 'dart:developer';

import 'package:app/application/services/alarm_service.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_strategy.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';

final class SimpleAlarmService with RepositoryStreamer<Alarm> implements AlarmService {
  int? _eventId;

  final AlarmRepository _alarmRepository;
  final EventsStorageRepository _eventRepository;

  StreamSubscription<int>? _timerSubscription;

  StreamSubscription<Event>? _eventStorageSubscription;

  SimpleAlarmService(this._alarmRepository, this._eventRepository) {
    _loadEventId();
    _eventStorageSubscription = _eventRepository.stream.listen(_onNewEventStored);
  }

  @override
  void startPolling() {
    log('Starting polling', name: 'SimpleEventService');

    if (_timerSubscription != null) {
      log('Polling already running', name: 'SimpleEventService');
      return;
    }

    _timerSubscription = Stream<int>.periodic(
      const Duration(seconds: 5),
      (final computationCount) => (computationCount + 5),
    ).listen(_onPoolingTime);
  }

  @override
  void stopPolling() {
    log('Stopping polling', name: 'SimpleEventService');
    _timerSubscription?.cancel();
    _timerSubscription = null;
  }

  void _onPoolingTime(final int period) async {
    log('Polling event count ${period / 5}', name: 'SimpleEventService');

    final template = AlarmFetchTemplate.byId(_eventId, _alarmRepository);

    log('Selected fetch template ${template.runtimeType}', name: 'SimpleAlarmService');

    final alarm = await template.fetchAlarm();

    if (alarm != null) {
      notifyListeners(alarm);
    }
  }

  void _onNewEventStored(final Event event) {
    _eventId = event.id;
  }

  Future<void> _loadEventId() async {
    final result = await _eventRepository.getEvent();
    if (result.isSuccess) {
      _eventId = result.success.id;
    }
  }

  @override
  void dispose() {
    stopPolling();
    _eventStorageSubscription?.cancel();
  }
}
