import 'dart:async';
import 'dart:developer';

import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/application/services/event_service.dart';
import 'package:app/domain/event/entity/event.dart';
import 'package:app/domain/event/repository/events_storage_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final List<FilePairDto> _mockedFiles = [
    const FilePairDto(name: 'Test pdf file', path: 'path1.pdf'),
    const FilePairDto(name: 'Test jpg file', path: 'path2.jpg'),
    const FilePairDto(name: 'Test csv file', path: 'path3.csv'),
  ];

  StreamSubscription<Event>? _activeEventSubscription;

  EventDetailBloc() : super(EventDetailInitial()) {
    on<EventDetailIdPressed>((final event, final emit) {
      log('Load event for id ${event.eventId}', name: 'EventDetailBloc');
      emit(
        EventDetailLoadSuccess(
          unit: 'Test id ${event.eventId}',
          eventType: 'Test technologie',
          event: 'Test událost',
          technique: 'Střákačka Máňa',
          region: 'Středočeský',
          municipality: 'Sedlec',
          street: 'U ulu 1',
          object: 'Objekt 13',
          floor: '7. patro',
          explanation: 'Další vysvětlení',
          lastUpdate: DateFormat.yMd().add_Hms().format(DateTime.now()),
          otherTechnique: 'CAS 121212',
          notifier: 'John Doe',
          notifierNumber: '+420 123 456 789',
          files: _mockedFiles,
        ),
      );
    });

    on<EventDetailActiveRequested>((final event, final emit) async {
      log('Load active event', name: 'EventDetailBloc');
      final repository = GetIt.I<EventsStorageRepository>();
      final eventResult = await repository.getLastEvent();

      emit(
        EventDetailLoadSuccess(
          unit: 'Test jednotka',
          eventType: 'Test technologie',
          event: 'Test událost',
          technique: 'Střákačka Máňa',
          region: 'Středočeský',
          municipality: 'Sedlec',
          street: 'U ulu 1',
          object: 'Objekt 13',
          floor: '7. patro',
          explanation: 'Další vysvětlení',
          lastUpdate: DateFormat.yMd().add_Hms().format(eventResult.success.time),
          otherTechnique: 'CAS 121212',
          notifier: 'John Doe',
          notifierNumber: '+420 123 456 789',
          files: _mockedFiles,
        ),
      );
    });

    _activeEventSubscription = GetIt.I<EventService>().stream.listen(
          _onActiveEventUpdate,
        );
    GetIt.I<EventService>().startPolling();
  }

  void _onActiveEventUpdate(final Event event) {
    log('Active event updated $event', name: 'EventDetailBloc');
    add(EventDetailActiveRequested());
  }

  @override
  Future<void> close() {
    GetIt.I<EventService>().stopPolling();
    _activeEventSubscription?.cancel();
    return super.close();
  }
}
