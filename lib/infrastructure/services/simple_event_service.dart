import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/alarm_event/alarm_event.dart';
import 'package:app/domain/alerts/alert.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:app/infrastructure/utils/service_pooling.dart';

final class SimpleEventService with RepositoryStreamer<bool>, ServicePooling, L implements EventService {
  int _eventId = -1;

  final AlarmRepository _alarmRepository;

  final Alert _alert;

  SimpleEventService(
    this._alarmRepository,
    this._alert,
  );

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
    final result = await _alarmRepository.getLast();

    if (result.isFailure && result.failure is AlarmNotFound) {
      await _alert.clear();
      l.d('No active alarm');
      int newEventId = -1;
      if (newEventId != _eventId) {
        _eventId = newEventId;
        notifyListeners(false);
      }
      return;
    }

    if (result.isFailure) {
      l.w('Failure with active alarm');
      await _alert.clear();
      return;
    }

    final newEventId = result.success.id;
    if (_eventId != newEventId) {
      l.d('checking alarm_event id: $newEventId');
      _eventId = newEventId;
      _alert.setCurrentEvent(Event(_eventId, result.success.lastUpdate));

      notifyListeners(true);
    }
  }
}
