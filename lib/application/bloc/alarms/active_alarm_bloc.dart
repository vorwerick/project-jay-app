import 'dart:async';
import 'dart:developer';

import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/mappers/alarm_mapper.dart';
import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'active_alarm_event.dart';

part 'active_alarm_state.dart';

class ActiveAlarmBloc extends Bloc<ActiveAlarmEvent, ActiveAlarmState> with L {
  ActiveAlarmBloc() : super(ActiveAlarmInitial()) {
    on<ActiveAlarmStarted>((final event, final emit) async {
      l.d('Load active alarm requested');
      emit(ActiveAlarmLoadInProgress());

      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getAll();

      if (result.isFailure) {
        emit(ActiveAlarmFailure());
        return;
      }
      final alarmDTOs = result.success.map((final a) {
        final mapper = AlarmMapper(a);
        final alarm = mapper.toAlarmDetail();
        return alarm;
      }).toList();

      final first = alarmDTOs.firstOrNull;
      if (first != null) {
        GetIt.I<TextToSpeechService>().loadText(first.toSpeechText());
        if (GetIt.I<TextToSpeechService>().isRepeating()) {
          GetIt.I<TextToSpeechService>().start();
        }
      }

      emit(ActiveAlarmLoadSuccess(alarmDTOs, false));
    });
    on<ActiveAlarmSilentRefresh>((final event, final emit) async {
      log("Start pooling");
      final repository = GetIt.I<AlarmRepository>();
      log("TACK CO");
      final result = await repository.getAll();

      if (result.isFailure) {
        emit(ActiveAlarmFailure());
        return;
      }
      final alarmDTOs = result.success.map((final a) {
        final mapper = AlarmMapper(a);
        final alarm = mapper.toAlarmDetail();
        return alarm;
      }).toList();

      final first = alarmDTOs.firstOrNull;
      if (first != null) {
        GetIt.I<TextToSpeechService>().loadText(first.toSpeechText());
        if (GetIt.I<TextToSpeechService>().isRepeating()) {
          GetIt.I<TextToSpeechService>().start();
        }
      }

      emit(ActiveAlarmLoadSuccess(alarmDTOs, true));

      // GetIt.I<TextToSpeechService>().loadText(mapper.toSpeechText());
      // GetIt.I<TextToSpeechService>().start();
    });
  }

  @override
  Future<void> close() {
    l.d('Closing');
    return super.close();
  }
}
