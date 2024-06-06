import 'dart:async';

import 'package:app/application/extensions/l.dart';
import 'package:app/application/services/tts_service.dart';
import 'package:app/domain/common/result.dart';
import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';

final class TextToSpeechService with L implements TTSService {
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
    tts.setLanguage('cs');
    if (_isTTSEnabled) {
      l.i('Speaking $text');
      await tts.speak(text);
      return Future.value(Result.success(null));
    }
    l.i('TTS is disabled');
    return Future.value(Result.failure(TTSDisabled()));
  }

  void _onSettingsChange(final Setting setting) {
    l.d('Settings changed, TTS is: ${setting.isTTSEnabled}');
    _isTTSEnabled = setting.isTTSEnabled;
   
  }

  void _initIsTTSEnabled() {
    _settingRepository.isTTSEnabled().then((final result) {
      if (result.isSuccess) {
        l.d('TTS enabled: ${result.success}');
        _isTTSEnabled = result.success;
      }
    });
  }

  void dispose() {
    _settingSubscription.cancel();
  }
}
