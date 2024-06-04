import 'package:app/domain/events/domain_event.dart';

base class PublicEvent<T> extends DomainEvent {
  final T event;

  PublicEvent(this.event);

  @override
  String toString() => 'PublicEvent{event: $event}';
}
