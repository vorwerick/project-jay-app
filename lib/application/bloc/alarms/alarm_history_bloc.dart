import 'dart:developer';

import 'package:app/application/dto/event_dto.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_history_event.dart';
part 'alarm_history_state.dart';

class AlarmHistoryBloc extends Bloc<AlarmHistoryEvent, AlarmHistoryState> {
  AlarmHistoryBloc() : super(AlarmHistoryInitial()) {
    on<AlarmHistoryStarted>((final event, final emit) async {
      log('Load all events', name: 'EventsHistoryBloc');
      emit(AlarmHistoryLoadInProgress());

      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getAll();

      if (result.isFailure) {
        emit(AlarmHistoryLoadFailure());
        return;
      }

      final events = result.success
          .map(
            (final a) => EventDto(
              '${a.id}',
              a.title,
              DateTime.now(),
            ),
          )
          .toList();

      log('Loaded ${events.length} events', name: 'EventsHistoryBloc');

      emit(AlarmHistoryLoadSuccess(events));
    });
  }
}
