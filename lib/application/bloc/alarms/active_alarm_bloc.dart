import 'dart:async';

import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/mappers/alarm_mapper.dart';
import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/alarm/alarm_service.dart';
import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'active_alarm_event.dart';
part 'active_alarm_state.dart';

class ActiveAlarmBloc extends Bloc<ActiveAlarmEvent, ActiveAlarmState> with L {
  StreamSubscription<Alarm>? _activeAlarmSubscription;

  ActiveAlarmBloc() : super(ActiveAlarmInitial()) {
    on<ActiveAlarmStarted>((final event, final emit) async {
      l.d('Load active alarm requested');
      if (event.enableLiveUpdate) {
        _startActiveAlarmStream();
      }

      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getActiveAlarm();

      if (result.isFailure) {
        emit(ActiveAlarmFailure());
        return;
      }
      final alarm = AlarmMapper(result.success).toAlarmDetail();

      emit(ActiveAlarmLoadSuccess(alarm));
    });

    on<ActiveAlarmRefreshed>((final event, final emit) async {
      l.d('Refreshed alarm received');

      final alarm = AlarmMapper(event.alarm).toAlarmDetail();

      emit(ActiveAlarmLoadSuccess(alarm));
    });
  }

  @override
  Future<void> close() {
    l.d('Closing');
    _activeAlarmSubscription?.cancel();
    _activeAlarmSubscription = null;
    return super.close();
  }

  void _startActiveAlarmStream() {
    if (_activeAlarmSubscription != null) {
      l.w('Active alarm subscription is already active');
      return;
    }

    _activeAlarmSubscription = GetIt.I<AlarmService>().stream.listen(
          _onActiveEventUpdate,
        );
    GetIt.I<AlarmService>().startPolling();
  }

  void _onActiveEventUpdate(final Alarm alarm) {
    l.d('Active alarm updated, id: ${alarm.id}');
    if (!isClosed) {
      add(ActiveAlarmRefreshed(alarm));
    } else {
      l.w('Bloc is closed');
    }
  }
}
