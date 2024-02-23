import 'package:app/application/extensions/l.dart';
import 'package:app/application/shared/device_information.dart';
import 'package:app/application/shared/device_information_factory.dart';
import 'package:app/infrastructure/shared/info_plus_device_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class InfoPlusDeviceInformationFactory with L implements DeviceInformationFactory {
  DeviceInformation? _deviceInformation;

  @override
  Future<DeviceInformation> createDeviceInformation() async {
    if (_deviceInformation != null) {
      l.d('Returning cached device information.');
      return _deviceInformation!;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String? token = await FirebaseMessaging.instance.getToken();

    _deviceInformation = InfoPlusDeviceInformation(
      device: androidInfo.model,
      manufacturer: androidInfo.manufacturer,
      version: packageInfo.version,
      sdk: androidInfo.version.sdkInt,
      buildNumber: int.parse(packageInfo.buildNumber),
      firebaseToken: token ?? '',
    );
    l.d('Created new device information.');
    return _deviceInformation!;
  }
}
