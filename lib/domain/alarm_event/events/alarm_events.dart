import 'package:app/domain/alarm_event/alarm_event.dart';
import 'package:app/domain/alarm_event/entity/event.dart';
import 'package:app/domain/events/public_event.dart';

sealed class AlarmEvents extends PublicEvent<Event> {
  AlarmEvents(super.event);

  factory AlarmEvents.added(final Event event) => AlarmEventAdded(event);

  factory AlarmEvents.confirmed(final Event event) => AlarmEventConfirmed(event);

  factory AlarmEvents.rejected(final Event event) => AlarmEventRejected(event);

  factory AlarmEvents.failed(final Event event) => AlarmEventFailed(event);
}

final class AlarmEventAdded extends AlarmEvents {
  AlarmEventAdded(super.event);
}

final class AlarmEventConfirmed extends AlarmEvents {
  AlarmEventConfirmed(super.event);
}

final class AlarmEventRejected extends AlarmEvents {
  AlarmEventRejected(super.event);
}

final class AlarmEventFailed extends AlarmEvents {
  AlarmEventFailed(super.event);
}
