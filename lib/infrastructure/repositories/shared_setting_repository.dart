import 'dart:developer';

import 'package:app/domain/common/invalid_value_exception.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedSettingRepository with RepositoryStreamer<Setting> implements SettingRepository {
  static const String _isRegisteredKey = 'isRegistered';
  static const String _isTTSEnabledKey = 'isTTSEnabled';

  @override
  Future<Result<SettingRepositoryState, void>> enableTTS(final bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isTTSEnabledKey, enabled);
    _notify();
    return Result.success(null);
  }

  @override
  Future<Result<SettingRepositoryState, Setting>> getSetting() async {
    try {
      return Result.success(await _createSettingEntity());
    } on InvalidValueException catch (e) {
      return Result.failure(SettingRepositoryError(e));
    }
  }

  @override
  Future<Result<SettingRepositoryState, bool>> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();

    return Result.success(prefs.getBool(_isRegisteredKey) ?? false);
  }

  @override
  Future<Result<SettingRepositoryState, bool>> isTTSEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return Result.success(prefs.getBool(_isTTSEnabledKey) ?? true);
  }

  @override
  Future<Result<SettingRepositoryState, void>> registered(final bool isRegistered) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isRegisteredKey, isRegistered);
    _notify();

    return Result.success(null);
  }

  Future<void> _notify({final Setting? setting}) async {
    if (setting != null) {
      notifyListeners(setting);
    } else {
      try {
        notifyListeners(await _createSettingEntity());
      } on Exception catch (e) {
        log('Can not notify listeners', error: e, name: 'SharedSettingRepository');
      }
    }
  }

  Future<Setting> _createSettingEntity() async {
    final prefs = await SharedPreferences.getInstance();
    return Setting.createNew(
      prefs.getBool(_isTTSEnabledKey) ?? false,
      prefs.getBool(_isRegisteredKey) ?? false,
    );
  }
}
