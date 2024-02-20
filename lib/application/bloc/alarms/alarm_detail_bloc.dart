import 'dart:async';
import 'dart:developer';

import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/application/dto/mappers/alarm_mapper.dart';
import 'package:app/application/services/alarm_service.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_detail_event.dart';
part 'alarm_detail_state.dart';

class AlarmDetailBloc extends Bloc<AlarmDetailEvent, AlarmDetailState> {
  StreamSubscription<Alarm>? _activeAlarmSubscription;

  AlarmDetailBloc() : super(AlarmDetailInitial()) {
    on<AlarmDetailIdPressed>((final event, final emit) async {
      log('Load event for id ${event.eventId}', name: 'AlarmDetailBloc');
      emit(AlarmDetailLoadInProgress());
      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getById(event.eventId);

      if (result.isFailure) {
        emit(AlarmDetailLoadFailure());
        return;
      }

      final alarm = AlarmMapper(result.success).toAlarmDetail();

      emit(alarm);
    });

    on<AlarmDetailActiveRequested>((final event, final emit) async {
      log('Load active alarm', name: 'AlarmDetailBloc');

      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getLast();

      if (result.isFailure) {
        emit(AlarmDetailLoadFailure());
        return;
      }
      final alarm = AlarmMapper(result.success).toAlarmDetail();

      emit(alarm);
    });

    on<AlarmDetailRefreshed>((final event, final emit) async {
      log('Refreshed alarm', name: 'AlarmDetailBloc');

      final alarm = AlarmMapper(event.alarm).toAlarmDetail();

      emit(alarm);
    });

    _activeAlarmSubscription = GetIt.I<AlarmService>().stream.listen(
          _onActiveEventUpdate,
        );
    GetIt.I<AlarmService>().startPolling();
  }

  void _onActiveEventUpdate(final Alarm alarm) {
    log('Active alarm updated, id: ${alarm.id}', name: 'AlarmDetailBloc');
    if (!isClosed) {
      add(AlarmDetailRefreshed(alarm));
    } else {
      log('Bloc is closed', name: 'AlarmDetailBloc');
    }
  }

  @override
  Future<void> close() {
    _activeAlarmSubscription?.cancel();
    return super.close();
  }
}
