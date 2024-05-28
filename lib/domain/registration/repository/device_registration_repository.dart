import 'package:app/domain/common/result.dart';
import 'package:app/domain/registration/values/registration_code.dart';

abstract interface class DeviceRegistrationRepository {
  /// return true if the device was successfully registered
  Future<Result<DeviceRegistrationRepositoryState, bool>> registerDevice(
    final RegistrationCode code,
  );
}

sealed class DeviceRegistrationRepositoryState {}

final class DeviceRegistrationFailed extends DeviceRegistrationRepositoryState {
  final Exception exception;

  DeviceRegistrationFailed(this.exception);
}
