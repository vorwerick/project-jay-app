import 'package:app/domain/common/entity.dart';

final class Event extends Entity {
  final DateTime time;

  Event(super.id, this.time);

  Event.empty()
      : time = DateTime.now(),
        super.empty();

  @override
  String toString() => 'Event{id: $id, time: $time}';

  bool get isValid {
    final beforeTime = DateTime.now().add(const Duration(minutes: -30));

    if (time.isBefore(beforeTime)) {
      return false;
    }

    return true;
  }

  bool get isNotValid => !isValid;
}
