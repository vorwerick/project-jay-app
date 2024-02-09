import 'dart:developer';

import 'package:app/application/dto/alert_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  AlertBloc() : super(AlertInitial()) {
    on<AlertStarted>((event, emit) {
      log('Loading alerts', name: 'AlertBloc');

      // TODO(Vojjta): implement this use case
      final List<AlertDto> alerts = [];
      for (int i = 0; i < 10; i++) {
        alerts.add(AlertDto(unitName: 'Unit name: $i', role: 'Role', hasActiveAlarm: i == 1 ? true : false));
      }

      emit(CurrentAlertsState(alerts));
    });
  }
}
