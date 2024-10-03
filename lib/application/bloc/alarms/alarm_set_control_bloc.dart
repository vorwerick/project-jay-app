import 'dart:async';

import 'package:app/application/dto/mappers/alarm_mapper.dart';
import 'package:app/application/extensions/l.dart';
import 'package:app/domain/alarm/repository/confirmation_repository.dart';
import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/alarm_event/events/alarm_events.dart';
import 'package:app/domain/alerts/alert.dart';
import 'package:app/domain/events/domain_bus.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_set_control_event.dart';

part 'alarm_set_control_state.dart';

/// Used for confirming alarm event
class AlarmSetControlBloc extends Bloc<AlarmSetControlEvent, AlarmSetControlState>
    with L {
  StreamSubscription<AlarmEvents>? _alarmEventsSubscription;

  AlarmSetControlBloc() : super(AlarmSetControlInit()) {
    on<AlarmSetControlIdle>((final event, final emit) async {

    });
    on<AlarmSetControlAcceptPressed>((final event, final emit) async {
      emit(AlarmSetControlProcessing());
      final repository = GetIt.I<ConfirmationRepository>();

      final result = await repository.confirm(event.eventId);

      if (result.isFailure) {
        emit(AlarmSetControlFailed());
        return;
      }

      emit(AlarmSetControlSuccess());
    });

    on<AlarmSetControlRejectPressed>((final event, final emit) async {
      emit(AlarmSetControlProcessing());
      final repository = GetIt.I<ConfirmationRepository>();

      final result = await repository.reject(event.eventId);

      if (result.isFailure) {
        emit(AlarmSetControlFailed());
        return;
      }

      emit(AlarmSetControlSuccess());
    });
  }

  /*
  void _started(final AlarmControlStarted event, final Emitter<AlarmControlState> emit) async {

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

   */

  @override
  Future<void> close() {
    _alarmEventsSubscription?.cancel();
    return super.close();
  }
}
