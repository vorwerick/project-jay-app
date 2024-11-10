import 'dart:developer';

import 'package:app/domain/common/result.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:app/infrastructure/utils/repository_streamer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedSettingRepository
    with RepositoryStreamer<Setting>
    implements SettingRepository {
  static const String _isRegisteredKey = 'isRegistered';
  static const String _isTTSEnabledKey = 'isTTSEnabled';
  static const String _notificationSoundKey = 'notificationSound';
  static const String _mapKey = 'map';
  static const String _activeAlarmDuration = 'alarmDuration';

  @override
  Future<Result<SettingRepositoryState, void>> enableTTS(
    final bool enabled,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isTTSEnabledKey, enabled);
    _notify();
    return Result.success(null);
  }

  @override
  Future<Result<SettingRepositoryState, Setting>> getSetting() async {
    try {
      log('LyLASL');
      return Result.success(await _createSettingEntity());
    } on Exception catch (e) {
      log(e.toString());
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
  Future<Result<SettingRepositoryState, void>> registered(
    final bool isRegistered,
  ) async {
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
        log(
          'Can not notify listeners',
          error: e,
          name: 'SharedSettingRepository',
        );
      }
    }
  }

  Future<Setting> _createSettingEntity() async {
    final prefs = await SharedPreferences.getInstance();
    log('UHUO');
    final set = Setting.createNew(
      prefs.getString(_notificationSoundKey) ?? 'fire_siren',
      prefs.getString(_mapKey) ?? 'Google Maps',
      prefs.getInt(_activeAlarmDuration) ?? 10,
      prefs.getBool(_isTTSEnabledKey) ?? false,
      prefs.getBool(_isRegisteredKey) ?? false,
    );
    log('GLOGOG');
    return set;
  }

  @override
  Future<Result<SettingRepositoryState, String>> getNotificationSound() async {
    final prefs = await SharedPreferences.getInstance();
    return Result.success(
      prefs.getString(_notificationSoundKey) ?? 'fire_siren',
    );
  }

  @override
  Future<Result<SettingRepositoryState, void>> setNotificationSound(
    final String sound,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_notificationSoundKey, sound);
    _notify();
    return Result.success(null);
  }

  @override
  Future<Result<SettingRepositoryState, int>> getActiveAlarmDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return Result.success(prefs.getInt(_activeAlarmDuration) ?? 10);
  }

  @override
  Future<Result<SettingRepositoryState, void>> setActiveAlarmDuration(
    final int minutes,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_activeAlarmDuration, minutes);
    _notify();
    return Result.success(null);
  }

  @override
  Future<Result<SettingRepositoryState, String>> getMaps() async {
    final prefs = await SharedPreferences.getInstance();
    return Result.success(prefs.getString(_mapKey) ?? 'Google Maps');
  }

  @override
  Future<Result<SettingRepositoryState, void>> setMaps(final String map) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_mapKey, map);
    _notify();
    return Result.success(null);
  }
}
