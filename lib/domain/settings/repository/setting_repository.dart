import 'package:app/domain/common/result.dart';
import 'package:app/domain/settings/entity/settings.dart';

abstract interface class SettingRepository {
  Stream<Setting> get stream;

  Future<Result<SettingRepositoryState, Setting>> getSetting();

  Future<Result<SettingRepositoryState, void>> enableTTS(final bool enabled);

  Future<Result<SettingRepositoryState, bool>> isTTSEnabled();

  Future<Result<SettingRepositoryState, bool>> isRegistered();

  Future<Result<SettingRepositoryState, void>> registered(final bool isRegistered);

  Future<Result<SettingRepositoryState, String>> getNotificationSound();

  Future<Result<SettingRepositoryState, void>> setNotificationSound(final String sound);

  Future<Result<SettingRepositoryState, int>> getActiveAlarmDuration();

  Future<Result<SettingRepositoryState, void>> setActiveAlarmDuration(final int minutes);

  Future<Result<SettingRepositoryState, void>> setMaps(final String map);

  Future<Result<SettingRepositoryState, String>> getMaps();

  Future<Result<SettingRepositoryState, void>> setGameTimeResult(final int time);
}

sealed class SettingRepositoryState {}

final class SettingRepositoryError extends SettingRepositoryState {
  final Exception exception;

  SettingRepositoryError(this.exception);
}
