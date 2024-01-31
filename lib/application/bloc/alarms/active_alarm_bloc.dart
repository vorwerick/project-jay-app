import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'active_alarm_event.dart';
part 'active_alarm_state.dart';

class ActiveAlarmBloc extends Bloc<ActiveAlarmEvent, ActiveAlarmState> {
  ActiveAlarmBloc() : super(ActiveAlarmInitial()) {
    on<HasActiveAlarmEvent>((event, emit) {
      log('Checking if there is active alarm event', name: 'ActiveAlarmBloc');
      // TODO(Vojjta): implement event handler
      emit(ActiveAlarmInitial());
    });
  }
}
