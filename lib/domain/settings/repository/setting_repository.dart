import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/settings/entity/settings.dart';

abstract interface class SettingRepository {
  Stream<void> get stream;

  Future<Result<SettingRepositoryState, Setting>> getSetting();

  Future<Result<SettingRepositoryState, void>> enableTTS(final bool enabled);

  Future<Result<SettingRepositoryState, bool>> isTTSEnabled();
}

sealed class SettingRepositoryState {}

final class SettingRepositoryError extends SettingRepositoryState {
  final Exception exception;

  SettingRepositoryError(this.exception);
}
