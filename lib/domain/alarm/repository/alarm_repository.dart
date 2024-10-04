import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/common/result.dart';

abstract interface class AlarmRepository {
  Future<Result<AlarmRepositoryState, bool>> hasActiveAlarm();

  Future<Result<AlarmRepositoryState, List<Alarm>>> getAnnouncedAlarms();

  Future<Result<AlarmRepositoryState, List<Alarm>>> getAll();

  Future<Result<AlarmRepositoryState, Alarm>> getLast();

  Future<Result<AlarmRepositoryState, Alarm>> getById(final int id);
}

sealed class AlarmRepositoryState {}

final class AlarmRepositoryFailure extends AlarmRepositoryState {
  final String message;

  AlarmRepositoryFailure({this.message = 'Unknown error'});

  @override
  String toString() => 'AlarmRepositoryFailure: $message';
}

final class AlarmNotFound extends AlarmRepositoryState {}

final class AlarRepositoryError extends AlarmRepositoryState {
  final Exception exception;

  AlarRepositoryError(this.exception);
}
