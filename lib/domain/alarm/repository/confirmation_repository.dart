import 'package:app/domain/alarm/values/alarm_state.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/common/status/repository_state.dart';

abstract interface class ConfirmationRepository {
  Future<Result<RemoteRepositoryState, AlarmState>> getConfirmationState(final int id);

  Future<Result<RemoteRepositoryState, bool>> confirm(final int id);

  Future<Result<RemoteRepositoryState, bool>> reject(final int id);
}
