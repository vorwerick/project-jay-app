import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/badges/badge_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListEventPair extends StatelessWidget {
  final DateTime date;
  final String name;

  const ListEventPair({super.key, required this.date, required this.name});

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: JayColors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const BadgeText(data: 'A', color: JayColors.lightGrey),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JayWhiteText(
                      name,
                    ),
                    JayWhiteText(
                      DateFormat.yMd().format(date),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
