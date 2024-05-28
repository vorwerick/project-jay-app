import 'dart:async';

import 'package:app/application/extensions/l.dart';
import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/alarm_event/events/alarm_events.dart';
import 'package:app/domain/alerts/alert.dart';
import 'package:app/domain/events/domain_bus.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_control_event.dart';
part 'alarm_control_state.dart';

/// Used for confirming alarm event
class AlarmControlBloc extends Bloc<AlarmControlEvent, AlarmControlState> with L {
  final Alert _alert = GetIt.I<Alert>();

  StreamSubscription<AlarmEvents>? _alarmEventsSubscription;

  AlarmControlBloc() : super(AlarmControlInitial()) {
    on<AlarmControlStarted>(_started);
    on<AlarmControlAcceptPressed>(_accept);
    on<AlarmControlDelayPressed>(_delay);
    on<AlarmControlRejectPressed>(_reject);
    on<AlarmControlEventReceived>(_onEvent);

    _alarmEventsSubscription = DomainBus.I.on<AlarmEvents>().listen(_onAlarmEvent);
  }

  void _started(final AlarmControlStarted event, final Emitter<AlarmControlState> emit) async {
    await _alert.initDefaultEvent();
    if (_alert.hasActiveEvent) {
      switch (_alert.alarmState) {
        case NotAnnounced():
          return emit(AlarmControlOpen());
        case Announced():
          return emit(AlarmControlAccepted());
        case Closed():
          return emit(AlarmControlRejected());
        case NullAlarmState():
          return emit(AlarmControlEmpty());
      }
    }
    return emit(AlarmControlEmpty());
  }

  void _accept(final AlarmControlAcceptPressed event, final Emitter<AlarmControlState> emit) {
    _alert.accept();
  }

  void _delay(final AlarmControlDelayPressed event, final Emitter<AlarmControlState> emit) {
    l.w('Implement delay action');
  }

  void _reject(final AlarmControlRejectPressed event, final Emitter<AlarmControlState> emit) {
    _alert.reject();
  }

  void _onEvent(final AlarmControlEventReceived event, final Emitter<AlarmControlState> emit) => switch (event.event) {
        AlarmEventAdded() => emit(AlarmControlOpen()),
        AlarmEventConfirmed() => emit(AlarmControlAccepted()),
        AlarmEventRejected() => emit(AlarmControlRejected()),
        AlarmEventFailed() => emit(AlarmControlFailed()),
      };

  void _onAlarmEvent(final AlarmEvents event) {
    l.d('Alarm event: ${event.runtimeType}');
    add(AlarmControlEventReceived(event));
  }

  @override
  Future<void> close() {
    _alarmEventsSubscription?.cancel();
    return super.close();
  }
}
