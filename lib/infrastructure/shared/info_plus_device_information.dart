import 'package:app/application/shared/device_information.dart';
import 'package:equatable/equatable.dart';

final class InfoPlusDeviceInformation extends Equatable implements DeviceInformation {
  @override
  final String device;

  @override
  final String manufacturer;

  @override
  final String version;

  @override
  final int buildNumber;

  @override
  final String firebaseToken;

  @override
  final int sdk;

  const InfoPlusDeviceInformation({
    required this.device,
    required this.manufacturer,
    required this.version,
    required this.buildNumber,
    required this.sdk,
    required this.firebaseToken,
  });

  @override
  List<Object?> get props => [manufacturer, device, version, buildNumber, sdk, firebaseToken];

  @override
  bool? get stringify => true;
}
