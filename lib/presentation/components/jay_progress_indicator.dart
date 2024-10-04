import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayProgressIndicator extends StatelessWidget {
  final String text;
  const JayProgressIndicator({super.key, required this.text});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(strokeWidth: 4),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(text,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ),
          ],
        ),
      );
}
