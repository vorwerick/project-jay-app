import 'dart:async';

import 'package:app/domain/common/invalid_value_exception.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';

final class MockedSettingRepository implements SettingRepository {
  final StreamController<Setting> _streamController = StreamController<Setting>.broadcast();
  bool _isTTSEnabled = true;
  bool _isRegistered = false;

  @override
  Stream<Setting> get stream => _streamController.stream;

  @override
  Future<Result<SettingRepositoryState, Setting>> getSetting() async {
    // TODO(Vojjta): Get setting from local storage
    try {
      return Result.success(
        Setting.createNew(
          _isTTSEnabled,
          _isRegistered,
        ),
      );
    } on InvalidValueException catch (e) {
      return Result.failure(SettingRepositoryError(e));
    }
  }

  @override
  Future<Result<SettingRepositoryState, void>> enableTTS(final bool enabled) {
    _isTTSEnabled = enabled;
    // _streamController.add(null);
    return Future.value(Result.success(null));
  }

  @override
  Future<Result<SettingRepositoryState, bool>> isTTSEnabled() => Future.value(Result.success(_isTTSEnabled));

  @override
  Future<Result<SettingRepositoryState, bool>> isRegistered() async => Result.success(_isRegistered);

  @override
  Future<Result<SettingRepositoryState, void>> registered(final bool isRegistered) async {
    _isRegistered = isRegistered;

    return Result.success(null);
  }
}
