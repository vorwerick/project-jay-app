import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

final class PdfPage extends StatelessWidget {
  final String path;

  const PdfPage({super.key, required this.path});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const JayWhiteText('File'),
        ),
        body: JayContainer(
          child: Center(
            child: Text('File: $path'),
          ),
        ),
      );
}
