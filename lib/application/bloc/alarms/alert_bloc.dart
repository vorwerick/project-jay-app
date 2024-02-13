import 'dart:developer';

import 'package:app/application/dto/alert_dto.dart';
import 'package:app/application/services/tts_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  AlertBloc() : super(AlertInitial()) {
    on<AlertStarted>((final event, final emit) {
      log('Loading alerts', name: 'AlertBloc');

      // TODO(Vojjta): Remove this example
      GetIt.I<TTSService>().speak('Ahoj světe. Tady je text to speech služba.');

      // TODO(Vojjta): implement this use case
      final List<AlertDto> alerts = [];
      for (int i = 0; i < 10; i++) {
        alerts.add(AlertDto(unitName: 'Unit name: $i', role: 'Role', hasActiveAlarm: i == 1 ? true : false));
      }

      emit(CurrentAlertsState(alerts));
    });
  }
}
