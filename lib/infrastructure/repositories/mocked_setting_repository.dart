import 'dart:async';

import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/primitives/unexpected_value_exception.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class MockedSettingRepository implements SettingRepository {
  final StreamController<void> _streamController = StreamController<void>.broadcast();
  bool _isTTSEnabled = true;

  @override
  Stream<void> get stream => _streamController.stream;

  @override
  Future<Result<SettingRepositoryState, Setting>> getSetting() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // TODO(Vojjta): Get setting from local storage
    try {
      return Result.success(
        Setting.createNew(
          packageInfo.version,
          _isTTSEnabled,
        ),
      );
    } on UnexpectedValueException catch (e) {
      return Result.failure(SettingRepositoryError(e));
    }
  }

  @override
  Future<Result<SettingRepositoryState, void>> enableTTS(final bool enabled) {
    _isTTSEnabled = enabled;
    _streamController.add(null);
    return Future.value(Result.success(null));
  }

  @override
  Future<Result<SettingRepositoryState, bool>> isTTSEnabled() => Future.value(Result.success(_isTTSEnabled));
}
