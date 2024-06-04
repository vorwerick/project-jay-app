import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/mappers/alarm_mapper.dart';
import 'package:app/application/extensions/l.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_detail_event.dart';
part 'alarm_detail_state.dart';

class AlarmDetailBloc extends Bloc<AlarmDetailEvent, AlarmDetailState> with L {
  AlarmDetailBloc() : super(AlarmDetailInitial()) {
    // Pressed alarm_event
    on<AlarmDetailIdPressed>((final event, final emit) async {
      l.i('Load alarm_event for id ${event.eventId}');
      emit(AlarmDetailLoadInProgress());
      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getById(event.eventId);

      if (result.isFailure) {
        l.w('Failed to load alarm_event for id ${event.eventId}');
        emit(AlarmDetailLoadFailure());
        return;
      }

      final alarm = AlarmMapper(result.success).toAlarmDetail();

      emit(AlarmDetailLoadSuccess(alarm));
    });
  }
}
