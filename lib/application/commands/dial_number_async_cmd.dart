import 'package:app/application/commands/command.dart';
import 'package:url_launcher/url_launcher.dart';

final class DialNumberAsyncCmd implements AsyncCommand<bool> {
  final String phoneNumber;

  DialNumberAsyncCmd({
    required this.phoneNumber,
  });

  @override
  Future<bool> execute() async {
    final numberUrl = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(numberUrl)) {
      await launchUrl(numberUrl);
      return true;
    }
    return false;
  }
}
