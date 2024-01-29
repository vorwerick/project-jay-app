import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class BasicBadge extends StatelessWidget {
  final Color badgeColor;
  final double diameter;

  const BasicBadge({super.key, this.badgeColor = JayColors.badgeWarning, this.diameter = 42});

  @override
  Widget build(BuildContext context) => Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
        ),
      );
}
