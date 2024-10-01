import 'dart:developer';
import 'dart:io';

import 'package:app/application/extensions/l.dart';
import 'package:app/application/shared/device_information.dart';
import 'package:app/infrastructure/shared/info_plus_device_information.dart';
import 'package:app/infrastructure/utils/shared_prefs.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class InfoPlusDeviceInformationService with L {
  Future<DeviceInformation?> createDeviceInformation() async {
    DeviceInformation? deviceInformation;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? token = OneSignal.User.pushSubscription.id;
    log('TOKENZ:$token');
    if (token == null) {
      return null;
    }



    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      deviceInformation = InfoPlusDeviceInformation(
        device: iosInfo.model,
        manufacturer: iosInfo.identifierForVendor.toString(),
        version: packageInfo.version,
        sdk: 0,
        buildNumber: int.tryParse(packageInfo.buildNumber) ?? -1,
        firebaseToken: token,
      );
      l.d('Created new device information.');
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceInformation = InfoPlusDeviceInformation(
        device: androidInfo.model,
        manufacturer: androidInfo.manufacturer,
        version: packageInfo.version,
        sdk: androidInfo.version.sdkInt,
        buildNumber: int.tryParse(packageInfo.buildNumber) ?? -1,
        firebaseToken: token,
      );
      l.d('Created new device information.');
    }

    return deviceInformation;
  }
}
