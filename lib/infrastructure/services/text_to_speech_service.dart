import 'dart:async';
import 'dart:developer';

import 'package:app/application/services/tts_service.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';

final class TextToSpeechService implements TTSService {
  final SettingRepository _settingRepository;

  late StreamSubscription<void> _settingSubscription;

  bool _isTTSEnabled = false;

  final FlutterTts tts = FlutterTts();

  TextToSpeechService(this._settingRepository) {
    _initIsTTSEnabled();

    _settingSubscription = _settingRepository.stream.listen((final setting) {
      _onSettingsChange(setting);
    });
  }

  @override
  Future<Result<TTSServiceState, void>> speak(final String text) async {
    if (_isTTSEnabled) {
      log('Speaking $text', name: 'TextToSpeechService');
      await tts.speak(text);
      return Future.value(Result.success(null));
    }
    log('TTS is disabled', name: 'TextToSpeechService');
    return Future.value(Result.failure(TTSDisabled()));
  }

  void _onSettingsChange(final Setting setting) {
    log('Settings changed, TTS is: ${setting.isTTSEnabled}', name: 'TextToSpeechService');
    _isTTSEnabled = setting.isTTSEnabled;
  }

  void _initIsTTSEnabled() {
    _settingRepository.isTTSEnabled().then((final result) {
      if (result.isSuccess) {
        log('TTS enabled: ${result.success}', name: 'TextToSpeechService');
        _isTTSEnabled = result.success;
      }
    });
  }

  void dispose() {
    _settingSubscription.cancel();
  }
}
