import 'dart:async';

import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/alarm_event/alarm_event.dart';
import 'package:app/infrastructure/services/alarm/alarm_fetch_strategy.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:app/infrastructure/utils/service_pooling.dart';

final class SimpleAlarmService with RepositoryStreamer<Alarm>, ServicePooling, L implements AlarmService {
  int? _eventId;

  final AlarmRepository _alarmRepository;
  final EventsStorageRepository _eventRepository;

  StreamSubscription<Event>? _eventStorageSubscription;

  SimpleAlarmService(this._alarmRepository, this._eventRepository) {
    _loadEventId();
    _eventStorageSubscription = _eventRepository.stream.listen(_onNewEventStored);
  }

  @override
  void startPolling() {
    start(_onPoolingTime);
  }

  @override
  void stopPolling() {
    stop();
  }

  @override
  void dispose() {
    stop();
    _eventStorageSubscription?.cancel();
  }

  void _onPoolingTime() async {
    final template = AlarmFetchTemplate.byId(_eventId, _alarmRepository);

    l.d('Selected fetch template ${template.runtimeType}');

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
}
