import 'package:app/domain/event/entity/event.dart';

abstract interface class EventService {
  Stream<Event> get stream;

  void startPolling();

  void stopPolling();
}
