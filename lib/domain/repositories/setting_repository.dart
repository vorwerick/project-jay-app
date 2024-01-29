import 'package:app/domain/entities/settings.dart';
import 'package:app/domain/primitives/result.dart';

abstract interface class SettingRepository {
  Future<Result<SettingRepositoryState, Setting>> getSetting();
}

sealed class SettingRepositoryState {}

final class SettingRepositoryError extends SettingRepositoryState {
  final Exception exception;

  SettingRepositoryError(this.exception);
}
