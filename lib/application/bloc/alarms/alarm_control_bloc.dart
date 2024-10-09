import 'dart:async';
import 'dart:developer';

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

part 'alarm_control_event.dart';

part 'alarm_control_state.dart';

/// Used for confirming alarm event
class AlarmControlBloc extends Bloc<AlarmControlEvent, AlarmControlState>
    with L {
  final Alert _alert = GetIt.I<Alert>();

  StreamSubscription<AlarmEvents>? _alarmEventsSubscription;

  AlarmControlBloc() : super(AlarmControlStateLoad()) {
    on<AlarmControlGetStateStarted>((final event, final emit) async {
      final repository = GetIt.I<ConfirmationRepository>();

      emit(AlarmControlStateLoading());

      final result = await repository.getConfirmationState(event.eventId);

      if (result.isFailure) {
        emit(AlarmControlStateFailed());
        return;
      }
      var currentUserFound = result.success.alarmMembers
          .any((final m) => event.memberId == m.memberId);
      if (currentUserFound) {
        final member = result.success.alarmMembers
            .firstWhere((m) => m.memberId == event.memberId);
        if (member.confirmAlarm) {
          emit(AlarmControlStateSuccessAccepted());
        } else {
          emit(AlarmControlStateSuccessRejected());
        }
      } else {
        emit(AlarmControlStateSuccessNoneMaximized());
      }
    });
    on<AlarmControlEdit>((final event, final emit) async {
      emit(AlarmControlStateSuccessNoneMaximized());
    });
    on<AlarmControlMinimize>((final event, final emit) async {
      emit(AlarmControlStateSuccessNoneMinimized());
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
