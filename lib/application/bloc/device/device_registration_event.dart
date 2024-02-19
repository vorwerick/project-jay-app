part of 'device_registration_bloc.dart';

@immutable
abstract class DeviceRegistrationEvent {}

final class DeviceRegistrationPressed extends DeviceRegistrationEvent {
  final String deviceKey;

  DeviceRegistrationPressed(this.deviceKey);
}
