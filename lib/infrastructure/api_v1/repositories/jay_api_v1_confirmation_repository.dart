import 'package:app/application/extensions/l.dart';
import 'package:app/domain/alarm/alarm.dart';
import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/common/status/repository_state.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_confirmation/alarm_confirmation.dart';
import 'package:app/infrastructure/api_v1/validation/api_response_validation.dart';

final class JayApiV1ConfirmationRepository with DioApiV1, L implements ConfirmationRepository {
  static const String confirmAction = '4';
  static const String rejectAction = '5';

  @override
  Future<Result<RemoteRepositoryState, bool>> confirm(final int id) async {
    l.i('Confirming alarm with id: $id');
    final AlarmConfirmation alarmConfirmation = AlarmConfirmation(id, confirmAction);
    return _sendConfirmation(alarmConfirmation);
  }

  @override
  Future<Result<RemoteRepositoryState, AlarmState>> getConfirmationState(final int id) async {
    final client = await createClient();

    try {
      final result = await client.getAlarmConfirmationById(id);

      if (ApiResponseValidation(result).isNotValid) {
        const String message = 'Invalid response for confirmation request';
        l.w(message);
        return Result.failure(RemoteRepositoryState.invalidResponse(message));
      }
      return Result.success(AlarmState.fromInt(result.data.alarmConfirmation!.alarmState));
    } on Exception catch (e) {
      l.e('Failed to fetch confirmation state', error: e);
      return Result.failure(RemoteRepositoryState.failure(e));
    }
  }

  @override
  Future<Result<RemoteRepositoryState, bool>> reject(final int id) {
    l.i('Rejecting alarm with id: $id');
    final AlarmConfirmation alarmConfirmation = AlarmConfirmation(id, rejectAction);
    return _sendConfirmation(alarmConfirmation);
  }

  Future<Result<RemoteRepositoryState, bool>> _sendConfirmation(final AlarmConfirmation alarmConfirmation) async {
    final client = await createClient();

    try {
      final result = await client.setAlarmConfirmation(alarmConfirmation);
      if (ApiResponseValidation(result).isNotValid) {
        return Result.success(false);
      }
      return Result.success(true);
    } on Exception catch (e) {
      l.e('Can not confirm alarm', error: e);
      return Result.failure(RemoteRepositoryState.failure(e));
    }
  }
}
