import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TextToSpeechControlPanel extends StatefulWidget implements PreferredSizeWidget{
  @override
  State<TextToSpeechControlPanel> createState() => _TextToSpeechControlPanelState();

  @override
  Size get preferredSize => Size(0, 32);
}

class _TextToSpeechControlPanelState extends State<TextToSpeechControlPanel> {
  @override
  Widget build(final BuildContext context) => textToSpeechControlPanel();

  Widget textToSpeechControlPanel() {
    final isSpeaking = GetIt.I<TextToSpeechService>().isSpeaking();
    final isRepeating = GetIt.I<TextToSpeechService>().isRepeating();
    return Container(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Přeříkávání",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(width: 16,),
          InkWell(
            onTap: () {
              if (isSpeaking) {
                GetIt.I<TextToSpeechService>().stop();
              } else {
                GetIt.I<TextToSpeechService>().start();
              }
              setState(() {});
            },
            child: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
          ),
          SizedBox(width: 16,),

          InkWell(
            onTap: () {
              GetIt.I<TextToSpeechService>().setRepeating(!isRepeating);
              setState(() {});
            },
            child: Icon(isRepeating ? Icons.repeat_on : Icons.repeat),
          ),
        ],
      ),
    );
  }
}