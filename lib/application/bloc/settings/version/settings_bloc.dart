import 'package:app/application/extensions/l.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> with L {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsStarted>((final event, final emit) async {
      l.i('Settings started');
      emit(SettingsLoadInProgress());

      final repository = GetIt.I<SettingRepository>();

      final settingResult = await repository.getSetting();

      if (settingResult.isSuccess) {
        emit(
          SettingsLoadSuccess(
            settingResult.success.isTTSEnabled,
          ),
        );
      }
    });

    on<SettingsEnableTTSPressed>((final event, final emit) async {
      l.i('Settings enable tts pressed');

      final repository = GetIt.I<SettingRepository>();

      repository.enableTTS(event.enable);
    });
  }
}
