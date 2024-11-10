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
  final bool isLast;
  final IconData icon;

  const ListParticipantPair({
    super.key,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.trailingTime,
    required this.confirmed, required
    this.isLast, required this.icon,
  });

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      ListTile(

          title: Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.black54,fontWeight: FontWeight.w600),
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                      color: badgeColor,
                    )),
                child: Icon(
                  icon,
                  weight: 12,
                  size: 20,
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
          )),
      if(!isLast)
        Divider()
    ],
  );


}
