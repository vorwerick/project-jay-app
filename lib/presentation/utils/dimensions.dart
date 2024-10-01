import 'package:flutter/material.dart';

class Dimensions{
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
  }
}
enum DeviceType { Phone, Tablet }

