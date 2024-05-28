sealed class AlarmState {
  AlarmState();

  factory AlarmState.fromInt(final int state) {
    switch (state) {
      case 1:
        return NotAnnounced();
      case 2:
        return Announced();
      case 3:
        return Closed();
      default:
        return NotAnnounced();
    }
  }

  factory AlarmState.nullState() => NullAlarmState();

  bool get isNull => this is NullAlarmState;

  bool get isNotNull => !isNull;
}

final class NotAnnounced extends AlarmState {
  @override
  String toString() => 'NotAnnounced';
}

final class Announced extends AlarmState {
  @override
  String toString() => 'Announced';
}

final class Closed extends AlarmState {
  @override
  String toString() => 'Closed';
}

final class NullAlarmState extends AlarmState {
  @override
  String toString() => 'NullAlarmState';
}
