import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/common/status/repository_state.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_confirmation/alarm_confirmation_detail.dart';

abstract interface class ConfirmationRepository {
  Future<Result<RemoteRepositoryState, AlarmConfirmationInfo>> getConfirmationState(final int id);

  Future<Result<RemoteRepositoryState, bool>> confirm(final int id);

  Future<Result<RemoteRepositoryState, bool>> reject(final int id);
}
