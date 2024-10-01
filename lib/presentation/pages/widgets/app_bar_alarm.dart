import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBarAlarm extends StatefulWidget {
  final AlarmDto eventDetail;

  const AppBarAlarm({super.key, required this.eventDetail});

  @override
  State<AppBarAlarm> createState() => _AppBarAlarmState();
}

class _AppBarAlarmState extends State<AppBarAlarm> {

  @override
  void initState() {
    GetIt.I<TextToSpeechService>().setOnStopListener((){
      if(mounted){
        setState(() {

        });
      }
    });
    super.initState();
  }
  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.eventDetail.event} - ${widget.eventDetail.lastUpdate}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          Text(
            '${widget.eventDetail.unit} - ${widget.eventDetail.region}, ${widget.eventDetail.municipality}, ${widget.eventDetail.street}',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(),
          ),
          Row(
            children: [
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
          textToSpeechControlPanel(),
        ],
      );

  Widget textToSpeechControlPanel() {
    final isSpeaking = GetIt.I<TextToSpeechService>().isSpeaking();
    final isRepeating = GetIt.I<TextToSpeechService>().isRepeating();
    return Container(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Přeříkávání",
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              if (isSpeaking) {
                 GetIt.I<TextToSpeechService>().stop();
              } else {
                GetIt.I<TextToSpeechService>().start();
              }
              setState(() {

              });
            },
            icon: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            onPressed: () {
              GetIt.I<TextToSpeechService>().setRepeating(!isRepeating);
              setState(() {

              });
            },
            icon: Icon(isRepeating ? Icons.repeat_on : Icons.repeat),
          ),
        ],
      ),
    );
  }
}
