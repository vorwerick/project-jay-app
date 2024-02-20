import 'package:app/application/shared/device_information.dart';

abstract class DeviceInformationFactory {
  Future<DeviceInformation> createDeviceInformation();
}
