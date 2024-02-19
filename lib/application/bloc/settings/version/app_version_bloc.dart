import 'dart:developer';

import 'package:app/application/shared/device_information.dart';
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
      final deviceInformation = await GetIt.I.getAsync<DeviceInformation>();

      final version = deviceInformation.version;

      emit(AppVersionLoadSuccess(version));
    });
  }
}
