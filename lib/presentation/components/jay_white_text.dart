import 'package:flutter/material.dart';

class JayWhiteText extends StatelessWidget {
  final String data;

  final double? fontSize;

  final FontWeight? fontWeight;

  const JayWhiteText(this.data, {final Key? key, this.fontSize, this.fontWeight}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: fontWeight,

        ),
      );
}
