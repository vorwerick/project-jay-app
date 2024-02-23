import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

class AppBarAlarm extends StatelessWidget {
  final AlarmDto eventDetail;

  const AppBarAlarm({super.key, required this.eventDetail});

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JayWhiteText(
            '${eventDetail.event} - ${eventDetail.lastUpdate}',
            fontSize: 16,
          ),
          JayWhiteText(
            '${eventDetail.unit} - ${eventDetail.region}, ${eventDetail.municipality}, ${eventDetail.street}',
            fontSize: 14,
          ),
        ],
      );
}
