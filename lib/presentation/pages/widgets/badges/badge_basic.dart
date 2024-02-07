import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class BadgeBasic extends StatelessWidget {
  final Color badgeColor;
  final double diameter;

  const BadgeBasic({super.key, this.badgeColor = JayColors.badgeWarning, this.diameter = 42});

  @override
  Widget build(final BuildContext context) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
        ),
      );
}
