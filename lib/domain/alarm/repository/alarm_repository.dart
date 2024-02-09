import 'package:app/domain/primitives/result.dart';

abstract interface class AlarmRepository {
  Future<Result<AlarmRepositoryState, bool>> hasActiveAlarm();
}

sealed class AlarmRepositoryState {}

final class AlarRepositoryError extends AlarmRepositoryState {
  final Exception exception;

  AlarRepositoryError(this.exception);
}
