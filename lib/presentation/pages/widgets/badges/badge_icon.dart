import 'package:app/presentation/pages/widgets/badges/badge_basic.dart';
import 'package:flutter/material.dart';

final class BadgeIcon extends StatelessWidget {
  final Color color;

  final IconData icon;

  const BadgeIcon({super.key, required this.color, required this.icon});

  @override
  Widget build(final BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          BadgeBasic(
            badgeColor: color,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      );
}
