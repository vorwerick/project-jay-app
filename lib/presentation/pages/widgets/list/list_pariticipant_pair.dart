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
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                BadgeBasic(badgeColor: badgeColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(subtitle),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(DateFormat('HH:mm').format(trailingTime)),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
