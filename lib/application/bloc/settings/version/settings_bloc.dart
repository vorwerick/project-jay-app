import 'dart:developer';

import 'package:app/domain/settings/entity/settings.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsStarted>((final event, final emit) async {
      log('Settings started', name: 'SettingsBloc');
      emit(SettingsLoadInProgress());

      final repository = GetIt.I<SettingRepository>();

      final settingResult = await repository.getSetting();

      if (settingResult.isSuccess) {
        emit(SettingsLoadSuccess.fromEntity(settingResult.success));
      }
    });

    on<SettingsEnableTTSPressed>((final event, final emit) async {
      log('Settings enable tts pressed', name: 'SettingsBloc');

      final repository = GetIt.I<SettingRepository>();

      repository.enableTTS(event.enable);
    });
  }
}
