import 'dart:async';
import 'dart:developer';

import 'package:app/application/services/tts_service.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';

final class TextToSpeechService implements TTSService {
  final SettingRepository _settingRepository;

  late StreamSubscription<void> _settingSubscription;

  bool _isTTSEnabled = false;

  final FlutterTts tts = FlutterTts();

  TextToSpeechService(this._settingRepository) {
    initIsTTSEnabled();

    _settingSubscription = _settingRepository.stream.listen((final _) {
      _onSettingsChange();
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

  void _onSettingsChange() {
    log('Settings changed, check if service is enabled', name: 'TextToSpeechService');
    initIsTTSEnabled();
  }

  void initIsTTSEnabled() {
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
