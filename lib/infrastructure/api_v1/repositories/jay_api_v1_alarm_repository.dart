import 'dart:developer';

import 'package:app/domain/alarm/entity/alarm.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/mappers/alarm_mapper.dart';

final class JayApiV1AlarmRepository with DioApiV1 implements AlarmRepository {
  @override
  Future<Result<AlarmRepositoryState, List<Alarm>>> getAll() async {
    final client = await createClient();

    try {
      final result = await client.getAlarmList();

      if (result.response.statusCode != 200) {
        return Result.failure(AlarmRepositoryFailure());
      }

      final alarms = result.data.alarms?.map((final a) => AlarmJsonMapper(a).toEntity()).toList();

      return Result.success(alarms ?? []);
    } on Exception catch (e) {
      return Result.failure(AlarRepositoryError(e));
    }
  }

  @override
  Future<Result<AlarmRepositoryState, bool>> hasActiveAlarm() async {
    final client = await createClient();

    try {
      final result = await client.getAlarmList();

      if (result.response.statusCode != 200) {
        return Result.failure(AlarmRepositoryFailure());
      }

      return Result.success(result.data.alarms?.isNotEmpty ?? false);
    } on Exception catch (e) {
      return Result.failure(AlarRepositoryError(e));
    }
  }

  @override
  Future<Result<AlarmRepositoryState, Alarm>> getById(final int id) async {
    final client = await createClient();

    try {
      final result = await client.getAlarmsById(id);

      if (result.response.statusCode != 200 || (result.data.alarm == null)) {
        return Result.failure(AlarmRepositoryFailure());
      }

      return Result.success(AlarmJsonMapper(result.data.alarm!).toEntity());
    } on Exception catch (e) {
      log('Can not load alarm by id: $id', error: e, name: 'JayApiV1AlarmRepository');
      return Result.failure(AlarRepositoryError(e));
    }
  }

  @override
  Future<Result<AlarmRepositoryState, Alarm>> getLast() async {
    final client = await createClient();

    try {
      final result = await client.getAlarmList();

      if (result.response.statusCode != 200) {
        return Result.failure(AlarmRepositoryFailure());
      }

      result.data.alarms?.sort((final a, final b) => a.orderUpdate.isAfter(b.orderUpdate) ? 1 : -1);

      final alarms = result.data.alarms?.map((final a) => AlarmJsonMapper(a).toEntity()).toList();

      final lastAlarm = alarms?.last;

      if (lastAlarm == null) {
        return Result.failure(AlarmRepositoryFailure());
      }

      return Result.success(lastAlarm);
    } on Exception catch (e) {
      return Result.failure(AlarRepositoryError(e));
    }
  }
}
