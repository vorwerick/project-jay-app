import 'dart:developer';

import 'package:app/application/shared/device_information.dart';
import 'package:app/domain/primitives/result.dart';
import 'package:app/domain/registration/repository/device_registration_repository.dart';
import 'package:app/domain/registration/values/registration_code.dart';
import 'package:app/infrastructure/api_v1/common/dio_api_v1.dart';
import 'package:app/infrastructure/api_v1/models/json/registration/device_registration.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final class JayApiV1RegistrationRepository with DioApiV1 implements DeviceRegistrationRepository {
  @override
  Future<Result<DeviceRegistrationRepositoryState, bool>> registerDevice(final RegistrationCode code) async {
    try {
      final deviceInfo = await GetIt.I.getAsync<DeviceInformation>();

      final request = DeviceRegistration(code.code, deviceInfo.firebaseToken);

      final client = await createClient();

      final result = await client.setDeviceRegistration(request);

      if (result.response.statusCode != 200) {
        log('Response has invalid status code: ${result.response.statusCode}', name: 'JayApiV1RegistrationRepository');
        return Result.success(false);
      }
      log('Registration response ${result.response.data}', name: 'JayApiV1RegistrationRepository');
      return Result.success(true);
    } on DioException catch (e) {
      log('Failed to register device', error: e, name: 'JayApiV1RegistrationRepository');
      return Result.failure(DeviceRegistrationFailed(e));
    }
  }
}
