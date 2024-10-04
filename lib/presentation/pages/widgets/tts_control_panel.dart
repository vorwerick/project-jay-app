import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TextToSpeechControlPanel extends StatefulWidget implements PreferredSizeWidget{
  @override
  State<TextToSpeechControlPanel> createState() => _TextToSpeechControlPanelState();

  @override
  Size get preferredSize => Size(0, 42);
}

class _TextToSpeechControlPanelState extends State<TextToSpeechControlPanel> {
  @override
  Widget build(final BuildContext context) => textToSpeechControlPanel();

  Widget textToSpeechControlPanel() {
    final isSpeaking = GetIt.I<TextToSpeechService>().isSpeaking();
    final isRepeating = GetIt.I<TextToSpeechService>().isRepeating();
    return Container(
      height: 42,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Přeříkávání",
            style: TextStyle(fontSize: 15),
          ),
          IconButton(
            onPressed: () {
              if (isSpeaking) {
                GetIt.I<TextToSpeechService>().stop();
              } else {
                GetIt.I<TextToSpeechService>().start();
              }
              setState(() {});
            },
            icon: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            onPressed: () {
              GetIt.I<TextToSpeechService>().setRepeating(!isRepeating);
              setState(() {});
            },
            icon: Icon(isRepeating ? Icons.repeat_on : Icons.repeat),
          ),
        ],
      ),
    );
  }
}