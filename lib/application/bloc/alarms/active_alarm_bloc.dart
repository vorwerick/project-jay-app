import 'dart:developer';

import 'package:app/application/commands/has_active_alarm_async_cmd.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'active_alarm_event.dart';
part 'active_alarm_state.dart';

class ActiveAlarmBloc extends Bloc<ActiveAlarmEvent, ActiveAlarmState> {
  ActiveAlarmBloc() : super(ActiveAlarmInitial()) {
    on<ActiveAlarmStarted>((final event, final emit) async {
      log('Checking if there is active alarm event', name: 'ActiveAlarmBloc');

      final AlarmRepository repository = GetIt.I<AlarmRepository>();

      final bool hasActiveAlarm = await HasActiveAlarmAsyncCommand(repository).execute();

      if (hasActiveAlarm) {
        emit(ActiveAlarmSuccess());
      } else {
        emit(ActiveAlarmFailure());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
