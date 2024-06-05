import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:flutter/material.dart';

class AppBarAlarm extends StatelessWidget {
  final AlarmDto eventDetail;

  const AppBarAlarm({super.key, required this.eventDetail});

  @override
  Widget build(final BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${eventDetail.event} - ${eventDetail.lastUpdate}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        Text(
          '${eventDetail.unit} - ${eventDetail.region}, ${eventDetail.municipality}, ${eventDetail.street}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(),
        ),
        Row(children: [Text(
            '15:30',
            style: Theme.of(context).textTheme.titleSmall!.copyWith()), Container(color: JayColors.secondary,child: Text("KOPIS",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: JayColors.primary),),)],)
      ]);
}
