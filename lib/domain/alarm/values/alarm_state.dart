sealed class AlarmState {
  AlarmState();

  factory AlarmState.fromInt(final int state) {
    switch (state) {
      case 0:
        return Open();
      case 1:
        return Accepted();
      case 2:
        return Declined();
      default:
        return Open();
    }
  }
}

final class Open extends AlarmState {
  @override
  String toString() => 'Open';
}

final class Accepted extends AlarmState {
  @override
  String toString() => 'Accepted';
}

final class Declined extends AlarmState {
  @override
  String toString() => 'Declined';
}
