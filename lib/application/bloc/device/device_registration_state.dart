part of 'device_registration_bloc.dart';

@immutable
abstract class DeviceRegistrationState {}

class DeviceRegistrationInitial extends DeviceRegistrationState {}

final class DeviceRegistrationInProgress extends DeviceRegistrationState {}

final class DeviceRegistrationSuccess extends DeviceRegistrationState {}

final class DeviceRegistrationInvalid extends DeviceRegistrationState {}

final class DeviceRegistrationFailure extends DeviceRegistrationState {}
