import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/badges/badge_basic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListParticipantPair extends StatelessWidget {
  final Color badgeColor;
  final String title;
  final String subtitle;
  final DateTime trailingTime;

  const ListParticipantPair({
    super.key,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.trailingTime,
  });

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('HH:mm').format(trailingTime),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.check,weight: 12,size: 32,color: JayColors.secondary,)
          ],
        ),
      );
}
