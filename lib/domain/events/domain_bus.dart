import 'dart:async';

import 'package:app/domain/events/domain_event.dart';

class DomainBus {
  static DomainBus? _instance;
  final StreamController _controller = StreamController.broadcast();

  DomainBus._internal();

  static DomainBus get I => _instance ?? (_instance = DomainBus._internal());

  Stream<T> on<T extends DomainEvent>() {
    assert(T != dynamic, 'You must specify the type of event you want to listen to');

    return _controller.stream.where((final event) => event is T).cast<T>();
  }

  void emit(final event) {
    assert(event is DomainEvent, 'You must emit an instance of DomainEvent');
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
