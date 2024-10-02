import 'dart:developer';

import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'alarm_gps_event.dart';

part 'alarm_gps_state.dart';

class AlarmGpsBloc extends Bloc<AlarmGpsEvent, AlarmGpsState> {
  AlarmGpsBloc() : super(AlarmGpsInitial()) {
    on<AlarmGpsStarted>((final event, final emit) async {
      log('Load last alarm gps', name: 'AlarmGpsBloc');
      emit(AlarmGpsLoadInProgress());

      final repository = GetIt.I<AlarmRepository>();

      final result = await repository.getById(event.eventId);

      if (result.isFailure) {
        emit(AlarmGpsLoadFailure());
        return;
      }

      final latLong = result.success.location;
      log('$latLong', name: 'AlarmGpsBloc');

      emit(AlarmGpsLoadSuccess(latLong.latitude, latLong.longitude));
    });
  }
}
