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
  bool _isSpeaking = false;
  bool _isRepeating = false;
  String? _currentText = null;
  Function? _onStopListener = null;

  final FlutterTts tts = FlutterTts();

  TextToSpeechService(this._settingRepository) {
    _initIsTTSEnabled();

    _settingSubscription = _settingRepository.stream.listen((final setting) {
      _onSettingsChange(setting);
    });
  }

  bool isSpeaking() => _isSpeaking;

  bool isRepeating() => _isRepeating;

  void setRepeating(final bool repeating) {
    _isRepeating = repeating;
  }

  Future stop() {
    _isSpeaking = false;
    return tts.stop();
  }

  void loadText(final String text){
    _currentText = text;
    tts.setLanguage('cs');
  }

  void clearText(){
    _currentText = null;
  }

  @override
  Future<Result<TTSServiceState, void>> start() async {
    if (_isSpeaking) {
      return Future.value(Result.failure(TTSServiceError(Exception("Service is started yet"))));
    }
    if(_currentText == null){
      return Future.value(Result.failure(TTSServiceError(Exception("No text"))));
    }

    _isSpeaking = true;
    if (_isTTSEnabled) {
      l.i('Speaking $_currentText');
      await tts.speak(_currentText!);

      tts.completionHandler = () {
        _onStopListener?.call();
        _onFinished();
      };

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
    _currentText = null;
  }

  void _onFinished() {
    _isSpeaking = false;
    if(_isRepeating){
      start();
    }
  }

  void setOnStopListener(final Function? onStop) {
    _onStopListener = onStop;
  }
}
