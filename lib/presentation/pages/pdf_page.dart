import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

final class PdfPage extends StatelessWidget {
  final String path;

  const PdfPage({super.key, required this.path});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title:  JayWhiteText(path),
        ),
        body: PDF(

        ).cachedFromUrl(
            "https://ncu.rcnpv.com.tw/Uploads/20131231103232738561744.pdf"),
      );
}
