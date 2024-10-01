import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/badges/badge_basic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListParticipantPair extends StatelessWidget {
  final Color badgeColor;
  final String title;
  final String subtitle;
  final DateTime trailingTime;
  final bool confirmed;

  const ListParticipantPair({
    super.key,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.trailingTime,
    required this.confirmed,
  });

  @override
  Widget build(final BuildContext context) => ListTile(
      title: Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: confirmed ? Colors.green : Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  color: confirmed ? Colors.green : Colors.red,
                )),
            child: Icon(
              confirmed ? Icons.check : Icons.clear,
              weight: 12,
              size: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.send,
                size: 12,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                DateFormat('HH:mm').format(trailingTime),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          )
        ],
      ));
}
