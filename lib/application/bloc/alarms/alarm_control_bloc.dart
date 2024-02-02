import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'alarm_control_event.dart';
part 'alarm_control_state.dart';

class AlarmControlBloc extends Bloc<AlarmControlEvent, AlarmControlState> {
  AlarmControlBloc() : super(AlarmControlInitial()) {
    on<AlarmControlAcceptPressed>((event, emit) {
      log('User pressed accept', name: 'AlarmControlBloc');
      // TODO(Vojjta): Implement accept
    });

    on<AlarmControlDelayPressed>((event, emit) {
      log('User pressed delay', name: 'AlarmControlBloc');
      // TODO(Vojjta): Implement delay
    });

    on<AlarmControlRejectPressed>((event, emit) {
      log('User pressed reject', name: 'AlarmControlBloc');
      // TODO(Vojjta): Implement reject
    });
  }
}
