import 'package:app/domain/primitives/entity.dart';

final class Event extends Entity {
  final DateTime time;

  Event(super.id, this.time);

  @override
  String toString() => 'Event{id: $id, time: $time}';
}
