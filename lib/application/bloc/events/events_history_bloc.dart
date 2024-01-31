import 'dart:developer';

import 'package:app/application/dto/event_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'events_history_event.dart';
part 'events_history_state.dart';

class EventsHistoryBloc extends Bloc<EventsHistoryEvent, EventsHistoryState> {
  EventsHistoryBloc() : super(EventsHistoryInitial()) {
    on<LoadHistoryEvent>((event, emit) {
      log('Load all events', name: 'EventsHistoryBloc');
      emit(EventsHistoryInitial());

      //TODO(vojjta): implement this use case
      final List<EventDto> events = [];

      for (int i = 0; i < 50; i++) {
        events.add(EventDto('$i', 'Event name $i', DateTime.now()));
      }
      emit(LoadedEventsHistory(events));
    });
  }
}
