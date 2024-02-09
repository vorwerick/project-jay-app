import 'dart:async';
import 'dart:developer';

import 'package:app/application/services/event_service.dart';
import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_remote_repository.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';

final class SimpleEventService implements EventService {
  final EventsRemoteRepository _eventRemoteRepository;
  final EventsStorageRepository _eventStorageRepository;

  StreamSubscription<int>? _timerSubscription;

  final StreamController<Event> _streamController = StreamController<Event>.broadcast();

  SimpleEventService(this._eventRemoteRepository, this._eventStorageRepository);

  @override
  Stream<Event> get stream => _streamController.stream;

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
    final eventResult = await _eventRemoteRepository.getLastEventDescription();

    if (eventResult.isSuccess) {
      _eventStorageRepository.addNewEvent(eventResult.success);
      _streamController.add(eventResult.success);
    } else {
      log('Error getting event: ${eventResult.failure.runtimeType}', name: 'SimpleEventService');
    }
  }
}
