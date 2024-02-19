import 'dart:developer';

import 'package:app/domain/primitives/invalid_value_exception.dart';
import 'package:app/domain/registration/repository/device_registration_repository.dart';
import 'package:app/domain/registration/values/registration_code.dart';
import 'package:app/domain/settings/repository/setting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'device_registration_event.dart';
part 'device_registration_state.dart';

class DeviceRegistrationBloc extends Bloc<DeviceRegistrationEvent, DeviceRegistrationState> {
  DeviceRegistrationBloc() : super(DeviceRegistrationInitial()) {
    on<DeviceRegistrationPressed>((final event, final emit) async {
      emit(DeviceRegistrationInProgress());
      log('Device registration pressed', name: 'DeviceRegistrationBloc');

      try {
        final code = RegistrationCode.fromString(event.deviceKey);

        final repository = GetIt.I<DeviceRegistrationRepository>();

        final result = await repository.registerDevice(code);

        if (result.isSuccess) {
          if (result.success) {
            await GetIt.I<SettingRepository>().registered(true);
            emit(DeviceRegistrationSuccess());
            return;
          } else {
            log('Device registration failed', name: 'DeviceRegistrationBloc');
          }
        }

        if (result.failure is DeviceRegistrationFailed) {
          final ex = (result.failure as DeviceRegistrationFailed).exception;
          log('Error during registration', error: ex, name: 'DeviceRegistrationBloc');
        } else {
          log('Unknown error during registration', name: 'DeviceRegistrationBloc');
        }

        emit(DeviceRegistrationFailure());
      } on InvalidValueException catch (e) {
        log('Invalid input', error: e, name: 'DeviceRegistrationBloc');
        emit(DeviceRegistrationInvalid());
      }
    });
  }
}
