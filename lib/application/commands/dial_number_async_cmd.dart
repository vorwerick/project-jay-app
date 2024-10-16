import 'dart:developer';

import 'package:app/application/commands/command.dart';
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
