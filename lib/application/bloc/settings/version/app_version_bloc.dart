import 'dart:developer';

import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  AppVersionBloc() : super(AppVersionInitial()) {
    on<AppVersionStarted>((final event, final emit) async {
      log('Getting app version', name: 'AppVersionBloc');
      final settingRepository = GetIt.I.get<SettingRepository>();

      final result = await settingRepository.getSetting();

      if (result.isSuccess) {
        emit(LoadedAppVersionState(result.success.appVersion.currentVersion));
      } else {
        emit(AppVersionInitial());
      }
    });
  }
}
