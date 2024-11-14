import 'dart:developer';
import 'dart:io';

import 'package:app/application/commands/command.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

final class DialNumberAsyncCmd implements AsyncCommand<bool> {
  final String phoneNumber;
  final String prefix;

  DialNumberAsyncCmd({
    required this.prefix,
    required this.phoneNumber,
  });

  @override
  Future<bool> execute() async {
    if (Platform.isAndroid) {
      String number = phoneNumber;
      if (!phoneNumber.contains('+')) {
        number = '$prefix$phoneNumber';
      }
      const platform = MethodChannel('recreateNotificationChannel');
      try {
        final result =
            await platform.invokeMethod<bool>('dialNumber', {'number': number});
        log('New channel created $result.');
        return true;
      } on PlatformException catch (e) {
        log('Failed to create new channel: ${e.message}');
        return false;
      }
    } else {
      Uri numberUrl = Uri.parse('tel://$phoneNumber');
      if (!phoneNumber.contains('+')) {
        numberUrl = Uri.parse('tel://$prefix$phoneNumber');
      }
      log('NUMBERO2: $numberUrl');
      if (await canLaunchUrl(numberUrl)) {
        await launchUrl(numberUrl);
        return true;
      }
      return false;
    }
  }
}
