import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

final LoadedDetailState mockedDetailState = LoadedDetailState(
  unit: 'Test',
  eventType: 'Test technologie',
  event: 'Test událost',
  technique: 'Střákačka Máňa',
  region: 'Středočeský',
  municipality: 'Sedlec',
  street: 'U ulu 1',
  object: 'Objekt 13',
  floor: '7. patro',
  explanation: 'Další vysvětlení',
  lastUpdate: '12.12.2021 11:44',
  otherTechnique: 'CAS 121212',
  notifier: 'Todo',
);

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailInitial()) {
    on<LoadDetailEvent>((event, emit) {
      log('Load event for id ${event.eventId}', name: 'EventDetailBloc');
      //TODO(vojjta): implement this use case
      emit(mockedDetailState);
    });

    on<LoadActiveEvent>((event, emit) {
      log('Load active event', name: 'EventDetailBloc');
      //TODO(vojjta): implement this use case
      emit(mockedDetailState);
    });
  }
}
