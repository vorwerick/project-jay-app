import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/badges/badge_basic.dart';
import 'package:flutter/material.dart';

class BadgeText extends StatelessWidget {
  final Color color;
  final String data;

  const BadgeText({super.key, required this.color, required this.data});

  @override
  Widget build(final BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          BadgeBasic(
            badgeColor: color,
          ),
          JayWhiteText(
            data,
            fontSize: 20,
          ),
        ],
      );
}
