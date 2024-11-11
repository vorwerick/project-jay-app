import 'dart:developer';
import 'dart:io';

import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

final class PdfPage extends StatelessWidget {
  final String path;

  const PdfPage({super.key, required this.path});

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        title: JayWhiteText(path),
      ),
      body: FutureBuilder<File?>(
        builder: (final context, final snapshot) {
          if (snapshot.hasData) {
            return PDFView(filePath: snapshot.data!.path);
          }
          return JayProgressIndicator(text: "Načítám soubor");
        },
        future: _copyAssetToLocal(),
      ));

  Future<File?> _copyAssetToLocal() async {
    try {
      var content = await rootBundle.load("assets/plan-domu.pdf");
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/plan-domu.mp4");
      file.writeAsBytesSync(content.buffer.asUint8List());
      return file;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
