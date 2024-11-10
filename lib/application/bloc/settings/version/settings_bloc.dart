import 'dart:developer';

import 'package:app/application/extensions/l.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> with L {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsStarted>((final event, final emit) async {
      l.i('Settings started');
      log("ABBABA");
      emit(SettingsLoadInProgress());
      log("CCCCCC");
      final repository = GetIt.I<SettingRepository>();
      log("XXXXXX");
      final settingResult = await repository.getSetting();

      log("HHHHH");
      if (settingResult.isSuccess) {
        log("RODODO");
        emit(
          SettingsLoadSuccess(
            settingResult.success.isTTSEnabled,
            settingResult.success.notificationSound,
            settingResult.success.activeAlarmDuration,
            settingResult.success.map,
          ),
        );
      }

      if (settingResult.isFailure) {
        log("KOKOKO");
      }
    });

    on<SettingsEnableTTSPressed>((final event, final emit) async {
      l.i('Settings enable tts pressed');

      final repository = GetIt.I<SettingRepository>();

      repository.enableTTS(event.enable);
    });
    on<SettingsSetMap>((final event, final emit) async {
      l.i('Settings set map ' +
          event.map.toString() );

      final repository = GetIt.I<SettingRepository>();

      repository.setMaps(event.map);
      add(SettingsStarted());
    });
    on<SettingsSetActiveAlarmDuration>((final event, final emit) async {
      l.i('Settings set alarm duration ' +
          event.minutes.toString() +
          " minutes");

      final repository = GetIt.I<SettingRepository>();

      repository.setActiveAlarmDuration(event.minutes);
      add(SettingsStarted());
    });
    on<SettingsSetNotificationSound>((final event, final emit) async {
      l.i('Settings set notification sound to ${event.sound}');

      final repository = GetIt.I<SettingRepository>();

      repository.setNotificationSound(event.sound);
      const platform = MethodChannel('recreateNotificationChannel');
      try {
        final result =
            await platform.invokeMethod<bool>('createNotificationChannel');
        l.i('New channel created $result.');
      } on PlatformException catch (e) {
        l.e('Failed to create new channel: ${e.message}');
      }
      add(SettingsStarted());
    });
  }
}
