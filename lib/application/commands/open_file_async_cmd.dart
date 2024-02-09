import 'dart:developer';
import 'dart:io';

import 'package:app/application/commands/command.dart';
import 'package:url_launcher/url_launcher.dart';

final class OpenFileAsyncCmd implements AsyncCommand<bool> {
  final File file;

  OpenFileAsyncCmd(this.file);

  @override
  Future<bool> execute() async {
    log('Opening file: ${file.path}', name: 'OpenFileAsyncCmd'); // check if file is valid
    if (!(await file.exists())) {
      log('File does not exist', name: 'OpenFileAsyncCmd');
      // return false;
    }
    final Uri fileUri = Uri.file(file.path);

    // check if file can be opened
    if (!(await canLaunchUrl(fileUri))) {
      log('Cannot launch file', name: 'OpenFileAsyncCmd');
      return false;
    }

    // open file
    log('Externally opening file: ${file.path} ', name: 'OpenFileAsyncCmd');
    await launchUrl(fileUri);
    return true;
  }
}
