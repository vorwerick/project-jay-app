import 'dart:async';

import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/tts_control_panel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarAlarm extends StatefulWidget {
  final AlarmDto eventDetail;

  const AppBarAlarm({super.key, required this.eventDetail});

  @override
  State<AppBarAlarm> createState() => _AppBarAlarmState();
}

class _AppBarAlarmState extends State<AppBarAlarm> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    GetIt.I<TextToSpeechService>().setOnStopListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            children: [
              Text(
                'POPLACH: ${widget.eventDetail.event} - ${widget.eventDetail.unit}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
              SizedBox(width: 4,),
              Container(
                color: JayColors.secondary,
                child: Text(
                  "KOPIS",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: JayColors.primary),
                ),
              ),
            ],
          ),
          TextToSpeechControlPanel(),
        ],
      );



}
