import 'package:app/domain/alarm/alarm.dart';
import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/alarm_event/alarm_event.dart';
import 'package:app/domain/events/domain_bus.dart';

/// Aggregate for alarm events
final class Alert {
  Event _event = Event.empty();

  AlarmState _alarmState = AlarmState.nullState();

  final ConfirmationRepository _confirmationRepository;

  final EventsStorageRepository _eventsStorageRepository;

  Alert(this._confirmationRepository, this._eventsStorageRepository);

  bool get hasActiveEvent => _event.isNotEmpty && _alarmState.isNotNull;

  int get eventId {
    assert(_event.isNotEmpty, 'Valid event is not set, please use hasActiveEvent to check if event is set');
    return _event.id;
  }

  AlarmState get alarmState {
    assert(_event.isNotEmpty, 'Valid event is not set');
    assert(_alarmState.isNotNull, 'Valid alarm state is not set');

    return _alarmState;
  }

  Future<void> initDefaultEvent() async {
    if (_event.isNotEmpty) {
      // not necessary to get event from storage
      return;
    }

    final result = await _eventsStorageRepository.getEvent();
    if (result.isFailure) {
      return;
    }

    _event = result.success;

    final confirmationResult = await _confirmationRepository.getConfirmationState(_event.id);

    if (result.isFailure) {
      return;
    }

    _alarmState = confirmationResult.success;
  }

  Future<void> setCurrentEvent(final Event event) async {
    if (_event == event) {
      // event is the same, no need to update
      return;
    }

    if (_event.isNotValid) {
      clear();
      return;
    }
    // store valid event
    _event = event;
    await _eventsStorageRepository.addNewEvent(event);

    final result = await _confirmationRepository.getConfirmationState(
      event.id,
    );

    if (result.isFailure) {
      return;
    }

    _alarmState = result.success;
    DomainBus.I.emit(AlarmEvents.added(event));
  }

  Future<void> clear() {
    _event = Event.empty();
    _alarmState = AlarmState.nullState();
    return _eventsStorageRepository.deleteEvent();
  }

  Future<void> accept() async {
    assert(_event.isNotEmpty, 'Provide valid alarm_event to accept');

    final result = await _confirmationRepository.confirm(_event.id);
    if (result.isSuccess && result.success) {
      DomainBus.I.emit(AlarmEvents.confirmed(_event));
    } else {
      DomainBus.I.emit(AlarmEvents.failed(_event));
    }
  }

  Future<void> reject() async {
    assert(_event.isNotEmpty, 'Provide valid alarm_event to reject');
    final result = await _confirmationRepository.reject(_event.id);
    if (result.isSuccess && result.success) {
      DomainBus.I.emit(AlarmEvents.rejected(_event));
    } else {
      DomainBus.I.emit(AlarmEvents.failed(_event));
    }
  }
}
